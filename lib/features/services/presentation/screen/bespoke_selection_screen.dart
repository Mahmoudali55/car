import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BespokeSelectionScreen extends StatefulWidget {
  const BespokeSelectionScreen({super.key});

  @override
  State<BespokeSelectionScreen> createState() => _BespokeSelectionScreenState();
}

class _BespokeSelectionScreenState extends State<BespokeSelectionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _yearFromController = TextEditingController();
  final _yearToController = TextEditingController();
  final _budgetMinController = TextEditingController();
  final _budgetMaxController = TextEditingController();
  final _descriptionController = TextEditingController();

  double _performancePriority = 3.0;
  double _comfortPriority = 4.0;
  double _techPriority = 3.0;
  double _economyPriority = 3.0;
  double _offroadPriority = 2.0;

  @override
  void dispose() {
    _brandController.dispose();
    _yearFromController.dispose();
    _yearToController.dispose();
    _budgetMinController.dispose();
    _budgetMaxController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitSearch() {
    if (_formKey.currentState!.validate()) {
      showDialog(
        context: context,
        builder: (context) => FadeInUp(
          duration: const Duration(milliseconds: 300),
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: AppColor.cardColor(context),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.check_circle_outline_rounded,
                  color: AppColor.greenColor(context),
                  size: 60.sp,
                ),
                Gap(16.h),
                Text(
                  AppLocaleKey.bespokeSearchSuccessTitle.tr(),
                  style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  AppLocaleKey.bespokeSearchSuccessDesc.tr(),
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context)),
                  textAlign: TextAlign.center,
                ),
                Gap(20.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Go back
                  },
                  text: AppLocaleKey.ok.tr(),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget _buildPrioritySlider({
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
                Gap(8.w),
                Text(
                  title,
                  style: AppTextStyle.bodyMedium(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              '${value.toStringAsFixed(0)}/5',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor(context),
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            activeTrackColor: AppColor.primaryColor(context),
            inactiveTrackColor: AppColor.borderColor(context).withValues(alpha: 0.3),
            thumbColor: AppColor.primaryColor(context),
            overlayColor: AppColor.primaryColor(context).withValues(alpha: 0.12),
            valueIndicatorColor: AppColor.primaryColor(context),
          ),
          child: Slider(value: value, min: 1.0, max: 5.0, divisions: 4, onChanged: onChanged),
        ),
        Gap(6.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.bespokeSelection.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: AppColor.secondAppColor(context),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocaleKey.bespokeSearch.tr(),
                              style: AppTextStyle.titleMedium(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackTextColor(context),
                              ),
                            ),
                            Gap(6.h),
                            Text(
                              AppLocaleKey.bespokeSelectionDesc.tr(),
                              style: AppTextStyle.bodySmall(
                                context,
                              ).copyWith(color: AppColor.greyColor(context)),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.w),
                      Icon(
                        Icons.person_search_rounded,
                        size: 50.sp,
                        color: AppColor.primaryColor(context),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(24.h),

              // Priority Sliders Section
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.yourPriorities.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(16.h),
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColor.secondAppColor(context),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColor.borderColor(context).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Column(
                        children: [
                          _buildPrioritySlider(
                            title: AppLocaleKey.priorityPerformance.tr(),
                            value: _performancePriority,
                            icon: Icons.speed_rounded,
                            onChanged: (val) => setState(() => _performancePriority = val),
                          ),
                          _buildPrioritySlider(
                            title: AppLocaleKey.priorityComfort.tr(),
                            value: _comfortPriority,
                            icon: Icons.airline_seat_recline_extra_rounded,
                            onChanged: (val) => setState(() => _comfortPriority = val),
                          ),
                          _buildPrioritySlider(
                            title: AppLocaleKey.priorityTech.tr(),
                            value: _techPriority,
                            icon: Icons.rocket_launch_rounded,
                            onChanged: (val) => setState(() => _techPriority = val),
                          ),
                          _buildPrioritySlider(
                            title: AppLocaleKey.priorityEconomy.tr(),
                            value: _economyPriority,
                            icon: Icons.local_gas_station_rounded,
                            onChanged: (val) => setState(() => _economyPriority = val),
                          ),
                          _buildPrioritySlider(
                            title: AppLocaleKey.priorityOffroad.tr(),
                            value: _offroadPriority,
                            icon: Icons.terrain_rounded,
                            onChanged: (val) => setState(() => _offroadPriority = val),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              // Specs Form Fields
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.whatAreYouLookingFor.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),

                    // Brand Preferences
                    CustomFormField(
                      controller: _brandController,
                      title: AppLocaleKey.preferredBrandsTitle.tr(),
                      hintText: AppLocaleKey.brandsPreferenceHint.tr(),
                      validator: (value) =>
                          value == null || value.isEmpty ? AppLocaleKey.validateEmpty.tr() : null,
                    ),
                    Gap(16.h),

                    // Years range
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _yearFromController,
                            title: AppLocaleKey.yearRangeFrom.tr(),
                            hintText: '2020',
                            keyboardType: TextInputType.number,
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: CustomFormField(
                            controller: _yearToController,
                            title: AppLocaleKey.yearRangeTo.tr(),
                            hintText: '2026',
                            keyboardType: TextInputType.number,
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),

                    // Budget range
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _budgetMinController,
                            title: AppLocaleKey.budgetMin.tr(),
                            hintText: AppLocaleKey.sarMinBudgetHint.tr(),
                            keyboardType: TextInputType.number,
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: CustomFormField(
                            controller: _budgetMaxController,
                            title: AppLocaleKey.budgetMax.tr(),
                            hintText: AppLocaleKey.sarMaxBudgetHint.tr(),
                            keyboardType: TextInputType.number,
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),

                    // Text Description
                    CustomFormField(
                      controller: _descriptionController,
                      title: AppLocaleKey.additionalSpecs.tr(),
                      hintText: AppLocaleKey.carDescriptionHint.tr(),
                      maxLines: 4,
                    ),

                    Gap(32.h),

                    // Submit
                    CustomButton(
                      onPressed: _submitSearch,
                      text: AppLocaleKey.startBespokeSearch.tr(),
                    ),
                    Gap(30.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
