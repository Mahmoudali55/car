import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/car_quotation_preview_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
              color: AppColor.blackColor(context).withValues(alpha: 0.1),
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
                color: AppColor.greyColor(context).withValues(alpha: 0.2),
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
                          style: AppTextStyle.titleLarge(context).copyWith(
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
                      backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.05),
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
                  SectionTitleWidget(
                    title: AppLocaleKey.customPrice.tr(),
                    icon: Icons.payments_rounded,
                  ),
                  Gap(12.h),
                  CustomFormField(
                    radius: 12.r,
                    controller: _priceController,
                    hintText: '0',
                    suffixIcon: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          AppImages.sar,
                          width: 15.w,
                          height: 15.h,
                          colorFilter: ColorFilter.mode(
                            AppColor.primaryColor(context),
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  Gap(32.h),
                  SectionTitleWidget(
                    title: AppLocaleKey.instantSpecs.tr(),
                    icon: Icons.auto_awesome_rounded,
                  ),
                  Gap(12.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomFormField(
                          radius: 12.r,
                          controller: _specController,
                          hintText: AppLocaleKey.enterSpecTitle.tr(),
                          onSubmitted: (_) => _addSpec(),
                        ),
                      ),
                      Gap(12.w),
                      CustomButton(
                        width: 40.w,
                        height: 40.h,
                        radius: 12.r,
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
                            labelStyle: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.blueColor(context),
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
                  SectionTitleWidget(
                    title: AppLocaleKey.existingSpecs.tr(),
                    icon: Icons.list_alt_rounded,
                  ),
                  Gap(16.h),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12.w,
                      mainAxisSpacing: 12.h,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: widget.existingSpecs.length,
                    itemBuilder: (context, index) {
                      final key = widget.existingSpecs.keys.elementAt(index);
                      final value = widget.existingSpecs.values.elementAt(index);
                      return Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                        color: AppColor.greyColor(context).withValues(alpha: 0.05),
                        // padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        // decoration: BoxDecoration(
                        //   color: AppColor.greyColor(context).withValues(alpha: 0.05),
                        //   borderRadius: BorderRadius.circular(16.r),
                        // ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
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
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(24.w, 0, 24.w, 40.h),
              child: CustomButton(
                onPressed: () async {
                  final Map<String, String> stringCar = {
                    'name': widget.carName,
                    'price': _priceController.text,
                    'year':
                        widget.existingSpecs[AppLocaleKey.agentYearMade.tr()] ??
                        widget.existingSpecs[AppLocaleKey.manufacturingYear.tr()] ??
                        '',
                    'mileage':
                        widget.existingSpecs[AppLocaleKey.agentSimNumber.tr()] ??
                        widget.existingSpecs[AppLocaleKey.mileage.tr()] ??
                        '',
                    'color':
                        widget.existingSpecs[AppLocaleKey.agentColor.tr()] ??
                        widget.existingSpecs[AppLocaleKey.exteriorColor.tr()] ??
                        '',
                    'instantSpecs': _instantSpecs.join(' | '),
                    ...widget.existingSpecs,
                  };

                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarQuotationPreviewScreen(car: stringCar),
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
}
