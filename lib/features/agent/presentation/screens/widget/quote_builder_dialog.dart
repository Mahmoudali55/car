import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/pdf_preview_screen.dart';
import 'package:car/core/utils/pdf_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class QuoteBuilderDialog extends StatefulWidget {
  final String carName;
  final double initialPrice;
  final Map<String, String> existingSpecs;

  const QuoteBuilderDialog({
    super.key,
    required this.carName,
    required this.initialPrice,
    required this.existingSpecs,
  });

  static void show(
    BuildContext context, {
    required String carName,
    required double initialPrice,
    required Map<String, String> existingSpecs,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QuoteBuilderDialog(
        carName: carName,
        initialPrice: initialPrice,
        existingSpecs: existingSpecs,
      ),
    );
  }

  @override
  State<QuoteBuilderDialog> createState() => _QuoteBuilderDialogState();
}

class _QuoteBuilderDialogState extends State<QuoteBuilderDialog> {
  late TextEditingController _priceController;
  final TextEditingController _specController = TextEditingController();
  final List<String> _instantSpecs = [];

  @override
  void initState() {
    super.initState();
    _priceController = TextEditingController(text: widget.initialPrice.toInt().toString());
  }

  @override
  void dispose() {
    _priceController.dispose();
    _specController.dispose();
    super.dispose();
  }

  void _addSpec() {
    if (_specController.text.trim().isNotEmpty) {
      setState(() {
        _instantSpecs.add(_specController.text.trim());
        _specController.clear();
      });
    }
  }

  void _removeSpec(int index) {
    setState(() {
      _instantSpecs.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 300),
      child: Container(
        height: 0.85.sh,
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 40,
              offset: const Offset(0, -10),
            ),
          ],
        ),
        child: Column(
          children: [
            Gap(12.h),
            // Handle
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: AppColor.greyColor(context).withOpacity(0.2),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(20.h),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocaleKey.generateQuote.tr(),
                          style: TextStyle(
                            color: AppColor.blackTextColor(context),
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Text(
                          widget.carName,
                          style: AppTextStyle.bodyMedium(context).copyWith(
                            color: AppColor.greyColor(context),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close_rounded, color: AppColor.hintColor(context)),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColor.greyColor(context).withOpacity(0.05),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(24.w, 32.h, 24.w, 100.h),
                physics: const BouncingScrollPhysics(),
                children: [
                  // Price Section
                  _buildSectionTitle(AppLocaleKey.customPrice.tr(), Icons.payments_rounded),
                  Gap(12.h),
                  _buildTextField(
                    controller: _priceController,
                    hint: '0',
                    suffix: AppLocaleKey.sar.tr(),
                    keyboardType: TextInputType.number,
                  ),
                  Gap(32.h),
                  // Instant Specs Section
                  _buildSectionTitle(AppLocaleKey.instantSpecs.tr(), Icons.auto_awesome_rounded),
                  Gap(12.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _specController,
                          hint: AppLocaleKey.enterSpecTitle.tr(),
                          onSubmitted: (_) => _addSpec(),
                        ),
                      ),
                      Gap(12.w),
                      CustomButton(
                        width: 56.w,
                        height: 56.h,
                        radius: 16.r,
                        onPressed: _addSpec,
                        child: Icon(Icons.add_rounded, color: AppColor.whiteColor(context)),
                      ),
                    ],
                  ),
                  if (_instantSpecs.isNotEmpty) ...[
                    Gap(16.h),
                    Wrap(
                      spacing: 8.w,
                      runSpacing: 8.h,
                      children: _instantSpecs.asMap().entries.map((entry) {
                        return FadeIn(
                          duration: const Duration(milliseconds: 200),
                          child: Chip(
                            label: Text(entry.value),
                            deleteIcon: Icon(Icons.close_rounded, size: 14.sp),
                            onDeleted: () => _removeSpec(entry.key),
                            backgroundColor: AppColor.blueColor(context).withValues(alpha: 0.1),
                            labelStyle: TextStyle(
                              color: AppColor.blueColor(context),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            side: BorderSide.none,
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  Gap(32.h),

                  // Existing Specs Section
                  _buildSectionTitle(AppLocaleKey.existingSpecs.tr(), Icons.list_alt_rounded),
                  Gap(16.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 2.8,
                    ),
                    itemCount: widget.existingSpecs.length,
                    itemBuilder: (context, index) {
                      final key = widget.existingSpecs.keys.elementAt(index);
                      final value = widget.existingSpecs.values.elementAt(index);
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColor.greyColor(context).withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              key,
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: AppColor.hintColor(context),

                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              value,
                              style: AppTextStyle.bodyMedium(
                                context,
                              ).copyWith(color: AppColor.blackTextColor(context)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Action Button
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
              child: CustomButton(
                onPressed: () async {
                  final String customPrice = _priceController.text;
                  final Map<String, dynamic> carData = {
                    'name': widget.carName,
                    'price': customPrice,
                    'year':
                        widget.existingSpecs[AppLocaleKey.agentYearMade.tr()] ??
                        widget.existingSpecs[AppLocaleKey.manufacturingYear.tr()] ??
                        '',
                    'mileage':
                        widget.existingSpecs[AppLocaleKey.agentDistance.tr()] ??
                        widget.existingSpecs[AppLocaleKey.mileage.tr()] ??
                        '',
                    'Color':
                        widget.existingSpecs[AppLocaleKey.agentColor.tr()] ??
                        widget.existingSpecs[AppLocaleKey.exteriorColor.tr()] ??
                        '',
                    'TRANSMISSION': 1,
                    'instantSpecs': _instantSpecs,
                  };

                  final doc = await PdfService.generateDocument(context: context, car: carData);

                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PdfPreviewScreen(doc: doc, fileName: '${widget.carName}_Quote.pdf'),
                      ),
                    );
                  }
                },
                radius: 16.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded, color: AppColor.whiteColor(context)),
                    Gap(10.w),
                    Text(
                      AppLocaleKey.downloadQuote.tr(),
                      style: AppTextStyle.bodyLarge(
                        context,
                      ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w900),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColor.primaryColor(context), size: 20.sp),
        Gap(8.w),
        Text(
          title,
          style: AppTextStyle.bodyLarge(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? suffix,
    TextInputType? keyboardType,
    Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      onSubmitted: onSubmitted,
      style: TextStyle(
        color: AppColor.blackTextColor(context),
        fontWeight: FontWeight.bold,
        fontSize: 15.sp,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColor.hintColor(context), fontSize: 14.sp),
        suffixText: suffix,
        suffixStyle: TextStyle(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
        filled: true,
        fillColor: AppColor.greyColor(context).withOpacity(0.05),
        contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.r),
          borderSide: BorderSide(color: AppColor.primaryColor(context), width: 1.5),
        ),
      ),
    );
  }
}
