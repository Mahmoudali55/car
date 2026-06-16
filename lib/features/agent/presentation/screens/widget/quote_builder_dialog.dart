import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/car_quotation_preview_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/section_title_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class QuoteBuilderDialog extends StatefulWidget {
  final GetBrandCarsDataModel car;
  final Map<String, String> existingSpecs;

  const QuoteBuilderDialog({super.key, required this.car, required this.existingSpecs});

  static void show(
    BuildContext context, {
    required GetBrandCarsDataModel car,
    required Map<String, String> existingSpecs,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => QuoteBuilderDialog(car: car, existingSpecs: existingSpecs),
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
    _priceController = TextEditingController(text: widget.car.price ?? '0');
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
            // Header
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Icon(
                      Icons.description_rounded,
                      color: AppColor.primaryColor(context),
                      size: 24.sp,
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocaleKey.generateQuote.tr(),
                          style: AppTextStyle.titleMedium(context).copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColor.blackTextColor(context),
                          ),
                        ),
                        Text(
                          widget.car.itemName,
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.close_rounded,
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitleWidget(
                      title: AppLocaleKey.agentSellingPrice.tr(),
                      icon: Icons.sell_rounded,
                    ),
                    Gap(16.h),
                    CustomFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      hintText: '0',
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AppImages.sar,
                          colorFilter: ColorFilter.mode(
                            AppColor.primaryColor(context),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      validator: (v) => null,
                    ),
                    Gap(32.h),
                    SectionTitleWidget(
                      title: AppLocaleKey.additionalSpecs.tr(),
                      icon: Icons.add_task_rounded,
                    ),
                    Gap(16.h),
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _specController,
                            hintText: AppLocaleKey.agentEnterSpec.tr(),
                            onSubmitted: (_) => _addSpec(),
                            validator: (v) => null,
                          ),
                        ),
                        Gap(12.w),
                        GestureDetector(
                          onTap: _addSpec,
                          child: Container(
                            height: 52.h,
                            width: 52.h,
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor(context),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Icon(
                              Icons.add_rounded,
                              color: AppColor.whiteColor(context),
                              size: 28.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (_instantSpecs.isNotEmpty) ...[
                      Gap(16.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: _instantSpecs.asMap().entries.map((entry) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor(context).withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(12.r),
                              border: Border.all(
                                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  entry.value,
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    color: AppColor.primaryColor(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Gap(8.w),
                                GestureDetector(
                                  onTap: () => _removeSpec(entry.key),
                                  child: Icon(
                                    Icons.cancel_rounded,
                                    size: 16.sp,
                                    color: AppColor.primaryColor(context),
                                  ),
                                ),
                              ],
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
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  key,
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                                    fontSize: 10.sp,
                                  ),
                                ),
                                Gap(2.h),
                                Text(
                                  value,
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.blackTextColor(context),
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
            ),

            // Footer Actions
            Padding(
              padding: EdgeInsets.all(24.w),
              child: CustomButton(
                onPressed: () {
                  final updatedCar = widget.car.copyWith(
                    price: _priceController.text,
                    carSpecification: _instantSpecs.join(' | '),
                  );

                  if (context.mounted) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CarQuotationPreviewScreen(car: updatedCar),
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
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
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
