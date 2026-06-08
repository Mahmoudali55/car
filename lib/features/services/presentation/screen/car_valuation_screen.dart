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

class CarValuationScreen extends StatefulWidget {
  const CarValuationScreen({super.key});
  @override
  State<CarValuationScreen> createState() => _CarValuationScreenState();
}

class _CarValuationScreenState extends State<CarValuationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _yearController = TextEditingController();
  final _mileageController = TextEditingController();
  final _colorController = TextEditingController();
  int _selectedConditionIndex = 0;
  int _selectedAccidentIndex = 0;
  int _selectedHistoryIndex = 0;
  int _uploadedPhotoCount = 0;

  @override
  void dispose() {
    _brandController.dispose();
    _yearController.dispose();
    _mileageController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  // Dynamic Valuation Estimator based on inputs
  Map<String, double> _estimateValuation() {
    final year = int.tryParse(_yearController.text.trim()) ?? 2023;
    final mileage = double.tryParse(_mileageController.text.trim()) ?? 40000;

    // Base price estimation by year
    double basePrice = 120000;
    if (year >= 2026) {
      basePrice = 240000;
    } else if (year == 2025) {
      basePrice = 200000;
    } else if (year == 2024) {
      basePrice = 160000;
    } else if (year == 2023) {
      basePrice = 130000;
    } else if (year == 2022) {
      basePrice = 100000;
    } else if (year == 2021) {
      basePrice = 85000;
    } else {
      basePrice = 65000;
    }

    // Mileage deduction: 0.25 SAR per km
    double mileageDeduction = mileage * 0.22;
    double currentVal = basePrice - mileageDeduction;

    // Condition multiplier
    // Conditions: Excellent, Very Good, Good, Fair, Needs Work
    final conditionMultipliers = [1.0, 0.90, 0.80, 0.65, 0.45];
    currentVal *= conditionMultipliers[_selectedConditionIndex];

    // Accident multiplier
    // Accidents: No Accidents, Minor, Major
    final accidentMultipliers = [1.0, 0.88, 0.60];
    currentVal *= accidentMultipliers[_selectedAccidentIndex];

    // Maintenance history multiplier
    // Maintenance: Agency, Certified Workshop, Regular Garage
    final maintenanceMultipliers = [1.0, 0.95, 0.85];
    currentVal *= maintenanceMultipliers[_selectedHistoryIndex];

    // Clamp value
    if (currentVal < 20000) {
      currentVal = 20000;
    }

    final lowEstimate = currentVal * 0.93;
    final highEstimate = currentVal * 1.07;

    return {'low': lowEstimate, 'high': highEstimate};
  }

  void _requestAppraisal() {
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
                  AppLocaleKey.valuationSuccessTitle.tr(),
                  style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  AppLocaleKey.valuationSuccessDesc.tr(),
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

  @override
  Widget build(BuildContext context) {
    final conditions = [
      AppLocaleKey.conditionExcellent.tr(),
      AppLocaleKey.conditionVeryGood.tr(),
      AppLocaleKey.conditionGood.tr(),
      AppLocaleKey.conditionFair.tr(),
      AppLocaleKey.conditionNeedsRepair.tr(),
    ];

    final accidentOptions = [
      AppLocaleKey.accidentNone.tr(),
      AppLocaleKey.accidentMinor.tr(),
      AppLocaleKey.accidentMajor.tr(),
    ];

    final maintenanceOptions = [
      AppLocaleKey.maintenanceAgency.tr(),
      AppLocaleKey.maintenanceCertified.tr(),
      AppLocaleKey.maintenanceRegular.tr(),
    ];

    final estimates = _estimateValuation();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.carValuation.tr(),
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
              // Info Card
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
                              AppLocaleKey.expertAppraisal.tr(),
                              style: AppTextStyle.bodyMedium(context).copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColor.blackTextColor(context),
                              ),
                            ),
                            Gap(6.h),
                            Text(
                              AppLocaleKey.valuationIntroDesc.tr(),
                              style: AppTextStyle.bodySmall(
                                context,
                              ).copyWith(color: AppColor.greyColor(context)),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.w),
                      Icon(
                        Icons.analytics_rounded,
                        size: 50.sp,
                        color: AppColor.primaryColor(context),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(24.h),

              // Inputs Section
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.carValuationInfo.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),

                    // Brand & Model
                    CustomFormField(
                      controller: _brandController,
                      title: AppLocaleKey.brandAndModel.tr(),
                      hintText: AppLocaleKey.toyotaCamryHint.tr(),
                      onChanged: (val) => setState(() {}),
                      validator: (value) =>
                          value == null || value.isEmpty ? AppLocaleKey.validateEmpty.tr() : null,
                    ),
                    Gap(16.h),

                    // Year and Mileage
                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _yearController,
                            title: AppLocaleKey.modelYear.tr(),
                            hintText: '2023',
                            keyboardType: TextInputType.number,
                            onChanged: (val) => setState(() {}),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: CustomFormField(
                            controller: _mileageController,
                            title: AppLocaleKey.mileage.tr(),
                            hintText: '45000',
                            keyboardType: TextInputType.number,
                            onChanged: (val) => setState(() {}),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),

                    // Color
                    CustomFormField(
                      controller: _colorController,
                      title: AppLocaleKey.exteriorColor.tr(),
                      hintText: AppLocaleKey.whiteBlackHint.tr(),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              // Dropdowns / Selectors
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Condition Dropdown
                    Text(
                      AppLocaleKey.overallCondition.tr(),
                      style: AppTextStyle.formTitleStyle(context),
                    ),
                    Gap(5.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: AppColor.textFormFillColor(context),
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColor.textFormBorderColor(context)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _selectedConditionIndex,
                          isExpanded: true,
                          dropdownColor: AppColor.secondAppColor(context),
                          items: List.generate(conditions.length, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(
                                conditions[index],
                                style: AppTextStyle.textFormStyle(context),
                              ),
                            );
                          }),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedConditionIndex = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    Gap(16.h),

                    // Accident History Dropdown
                    Text(
                      AppLocaleKey.accidentHistoryTitle.tr(),
                      style: AppTextStyle.formTitleStyle(context),
                    ),
                    Gap(5.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: AppColor.textFormFillColor(context),
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColor.textFormBorderColor(context)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _selectedAccidentIndex,
                          isExpanded: true,
                          dropdownColor: AppColor.secondAppColor(context),
                          items: List.generate(accidentOptions.length, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(
                                accidentOptions[index],
                                style: AppTextStyle.textFormStyle(context),
                              ),
                            );
                          }),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedAccidentIndex = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),

                    Gap(16.h),

                    // Maintenance History Dropdown
                    Text(
                      AppLocaleKey.maintenanceHistoryTitle.tr(),
                      style: AppTextStyle.formTitleStyle(context),
                    ),
                    Gap(5.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: AppColor.textFormFillColor(context),
                        borderRadius: BorderRadius.circular(5.r),
                        border: Border.all(color: AppColor.textFormBorderColor(context)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<int>(
                          value: _selectedHistoryIndex,
                          isExpanded: true,
                          dropdownColor: AppColor.secondAppColor(context),
                          items: List.generate(maintenanceOptions.length, (index) {
                            return DropdownMenuItem(
                              value: index,
                              child: Text(
                                maintenanceOptions[index],
                                style: AppTextStyle.textFormStyle(context),
                              ),
                            );
                          }),
                          onChanged: (val) {
                            if (val != null) {
                              setState(() {
                                _selectedHistoryIndex = val;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              // Mock Image Uploader
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.carImages.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),
                    Row(
                      children: List.generate(3, (index) {
                        final isUploaded = index < _uploadedPhotoCount;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (isUploaded) {
                                  _uploadedPhotoCount--;
                                } else {
                                  _uploadedPhotoCount++;
                                }
                              });
                            },
                            child: Container(
                              height: 80.h,
                              margin: EdgeInsets.symmetric(horizontal: 4.w),
                              decoration: BoxDecoration(
                                color: AppColor.secondAppColor(context),
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                  color: isUploaded
                                      ? AppColor.greenColor(context)
                                      : AppColor.borderColor(context).withValues(alpha: 0.3),
                                  width: 1.5,
                                ),
                              ),
                              child: Center(
                                child: isUploaded
                                    ? Icon(
                                        Icons.check_circle_rounded,
                                        color: AppColor.greenColor(context),
                                        size: 30.sp,
                                      )
                                    : Icon(
                                        Icons.add_photo_alternate_rounded,
                                        color: AppColor.greyColor(context),
                                        size: 26.sp,
                                      ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    Gap(8.h),
                    Center(
                      child: Text(
                        AppLocaleKey.pressToAddPhotos.tr(),
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(fontSize: 10.sp, color: AppColor.greyColor(context)),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.iconColoramber(context).withValues(alpha: 0.12),
                        AppColor.iconColoramber(context).withValues(alpha: 0.04),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColor.iconColoramber(context).withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        AppLocaleKey.instantEstimatedValuation.tr(),
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.iconColoramber(context).withValues(alpha: 0.7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '${estimates['low']!.toStringAsFixed(0)} - ${estimates['high']!.toStringAsFixed(0)}',
                            style: AppTextStyle.titleLarge(context).copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColor.blackTextColor(context),
                              letterSpacing: -0.5,
                            ),
                          ),
                          Gap(6.w),
                          Text(
                            AppLocaleKey.sar.tr(),
                            style: AppTextStyle.bodyMedium(
                              context,
                            ).copyWith(color: AppColor.greyColor(context)),
                          ),
                        ],
                      ),
                      Gap(6.h),
                      Text(
                        AppLocaleKey.valuationEstimatedNote.tr(),
                        style: TextStyle(fontSize: 9.sp, color: AppColor.greyColor(context)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              Gap(32.h),

              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: CustomButton(
                  onPressed: _requestAppraisal,
                  text: AppLocaleKey.requestValuationNow.tr(),
                ),
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
    );
  }
}
