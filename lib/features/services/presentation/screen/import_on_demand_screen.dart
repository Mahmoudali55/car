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

class ImportOnDemandScreen extends StatefulWidget {
  const ImportOnDemandScreen({super.key});

  @override
  State<ImportOnDemandScreen> createState() => _ImportOnDemandScreenState();
}

class _ImportOnDemandScreenState extends State<ImportOnDemandScreen> {
  final _formKey = GlobalKey<FormState>();
  final _brandController = TextEditingController();
  final _yearController = TextEditingController();
  final _specsController = TextEditingController();
  final _budgetController = TextEditingController();
  final _countryController = TextEditingController();
  final _notesController = TextEditingController();

  int _currentStep = 0;

  @override
  void dispose() {
    _brandController.dispose();
    _yearController.dispose();
    _specsController.dispose();
    _budgetController.dispose();
    _countryController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitRequest() {
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
                  AppLocaleKey.requestSubmittedSuccess.tr(),
                  style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                Gap(8.h),
                Text(
                  AppLocaleKey.importRequestSuccessDesc.tr(),
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context)),
                  textAlign: TextAlign.center,
                ),
                Gap(20.h),
                CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
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
    final steps = [
      {'title': AppLocaleKey.importStepRequest.tr(), 'icon': Icons.edit_note_rounded},
      {'title': AppLocaleKey.importStepCheck.tr(), 'icon': Icons.verified_user_rounded},
      {'title': AppLocaleKey.importStepShipping.tr(), 'icon': Icons.local_shipping_rounded},
      {'title': AppLocaleKey.importStepCustoms.tr(), 'icon': Icons.gavel_rounded},
      {'title': AppLocaleKey.importStepDelivery.tr(), 'icon': Icons.home_repair_service_rounded},
    ];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.importOnDemand.tr(),
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
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0F172A), Color(0xFF1E293B)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocaleKey.importOnDemand.tr(),
                              style: AppTextStyle.titleMedium(context).copyWith(
                                color: AppColor.whiteColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(6.h),
                            Text(
                              AppLocaleKey.importOnDemandDesc.tr(),
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: AppColor.whiteColor(context).withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.w),
                      Icon(
                        Icons.public_rounded,
                        size: 50.sp,
                        color: AppColor.primaryColor(context),
                      ),
                    ],
                  ),
                ),
              ),

              Gap(24.h),

              // Interactive Stepper Tracker
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.importJourneySteps.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: AppColor.secondAppColor(context),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: AppColor.borderColor(context).withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(steps.length, (index) {
                          final step = steps[index];
                          final isActive = index == _currentStep;
                          final isPassed = index < _currentStep;

                          return Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _currentStep = index;
                                });
                              },
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    padding: EdgeInsets.all(8.w),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isActive
                                          ? AppColor.primaryColor(context)
                                          : isPassed
                                          ? AppColor.primaryColor(context).withValues(alpha: 0.2)
                                          : AppColor.scaffoldColor(context),
                                      border: Border.all(
                                        color: isActive
                                            ? AppColor.primaryColor(context)
                                            : AppColor.borderColor(context),
                                        width: 1.5,
                                      ),
                                    ),
                                    child: Icon(
                                      step['icon'] as IconData,
                                      size: 18.sp,
                                      color: isActive
                                          ? AppColor.whiteColor(context)
                                          : isPassed
                                          ? AppColor.primaryColor(context)
                                          : AppColor.greyColor(context),
                                    ),
                                  ),
                                  Gap(6.h),
                                  Text(
                                    step['title'] as String,
                                    style: AppTextStyle.bodySmall(context).copyWith(
                                      fontSize: 10.sp,
                                      fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                                      color: isActive
                                          ? AppColor.blackTextColor(context)
                                          : AppColor.greyColor(context),
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              ),

              Gap(24.h),

              FadeInUp(
                delay: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.requestedCarDetails.tr(),
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Gap(12.h),

                    CustomFormField(
                      controller: _brandController,
                      title: AppLocaleKey.brandAndModel.tr(),
                      hintText: AppLocaleKey.mercedesSClassHint.tr(),
                      validator: (value) =>
                          value == null || value.isEmpty ? AppLocaleKey.validateEmpty.tr() : null,
                    ),
                    Gap(16.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _yearController,
                            title: AppLocaleKey.manufacturingYearHint.tr(),
                            hintText: '2024',
                            keyboardType: TextInputType.number,
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: CustomFormField(
                            controller: _specsController,
                            title: AppLocaleKey.preferredSpecs.tr(),
                            hintText: AppLocaleKey.gccUsSpecsHint.tr(),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),

                    Row(
                      children: [
                        Expanded(
                          child: CustomFormField(
                            controller: _budgetController,
                            title: AppLocaleKey.approximateBudget.tr(),
                            hintText: AppLocaleKey.sarBudgetHint.tr(),
                            keyboardType: TextInputType.number,
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                        Gap(12.w),
                        Expanded(
                          child: CustomFormField(
                            controller: _countryController,
                            title: AppLocaleKey.importCountry.tr(),
                            hintText: AppLocaleKey.germanyUsHint.tr(),
                            validator: (value) => value == null || value.isEmpty
                                ? AppLocaleKey.validateEmpty.tr()
                                : null,
                          ),
                        ),
                      ],
                    ),
                    Gap(16.h),

                    CustomFormField(
                      controller: _notesController,
                      title: AppLocaleKey.additionalNotes.tr(),
                      hintText: AppLocaleKey.importNotesHint.tr(),
                      maxLines: 4,
                    ),

                    Gap(32.h),

                    CustomButton(
                      onPressed: _submitRequest,
                      text: AppLocaleKey.sendImportRequest.tr(),
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
