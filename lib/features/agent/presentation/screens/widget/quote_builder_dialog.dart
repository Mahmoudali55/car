import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_footer_action_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_grid_view_exist_specs_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_quote_header_widget.dart';
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
            CustomQuoteHeaderWidget(widget: widget),

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
                      suffixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          AppImages.sar,
                          height: 20.h,
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
                    CustomGridViewExistSpecsWidget(widget: widget),
                  ],
                ),
              ),
            ),

            // Footer Actions
            CustomFooterActionWidget(
              widget: widget,
              instantSpecs: _instantSpecs,
              priceController: _priceController,
            ),
          ],
        ),
      ),
    );
  }
}
