import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/widgets/shared/elite_form_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SignatureStep extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController idController;
  final TextEditingController workController;
  final TextEditingController salaryController;

  const SignatureStep({
    super.key,
    required this.nameController,
    required this.phoneController,
    required this.idController,
    required this.workController,
    required this.salaryController,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: const Duration(milliseconds: 800),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              AppLocaleKey.applicationDetails.tr().toUpperCase(),
              style: AppTextStyle.titleMedium(context).copyWith(
                color: AppColor.whiteColor(context),
                fontWeight: FontWeight.w900,
                letterSpacing: 2.5,
                fontSize: 16.sp,
              ),
            ),
          ),
          Gap(40.h),
          EliteFormField(
            label: AppLocaleKey.fullLegalName.tr().toUpperCase(),
            hint: AppLocaleKey.enterFullName.tr(),
            controller: nameController,
          ),
          Gap(24.h),
          EliteFormField(
            label: AppLocaleKey.mobileNumber.tr().toUpperCase(),
            hint: AppLocaleKey.enterMobileNumber.tr(),
            controller: phoneController,
            type: TextInputType.phone,
          ),
          Gap(24.h),
          EliteFormField(
            label: AppLocaleKey.nationalId.tr().toUpperCase(),
            hint: AppLocaleKey.idNumberHint.tr(),
            controller: idController,
            type: TextInputType.number,
          ),
          Gap(24.h),
          EliteFormField(
            label: AppLocaleKey.workPlace.tr().toUpperCase(),
            hint: AppLocaleKey.employerHint.tr(),
            controller: workController,
          ),
          Gap(24.h),
          EliteFormField(
            label: AppLocaleKey.approxMonthlySalary.tr().toUpperCase(),
            hint: AppLocaleKey.amountInSarHint.tr(),
            controller: salaryController,
            type: TextInputType.number,
          ),
          Gap(32.h),
        ],
      ),
    );
  }
}
