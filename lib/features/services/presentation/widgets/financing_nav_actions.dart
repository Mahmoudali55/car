import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingNavActions extends StatelessWidget {
  final int currentStep;
  final VoidCallback onBack;
  final VoidCallback onNext;
  final String nextLabel;

  const FinancingNavActions({
    super.key,
    required this.currentStep,
    required this.onBack,
    required this.onNext,
    required this.nextLabel,
  });

  @override
  Widget build(BuildContext context) {
    final primary = AppColor.primaryColor(context);
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 20.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        border: Border(top: BorderSide(color: AppColor.borderColor(context))),
      ),
      child: Row(
        children: [
          if (currentStep > 0)
            Expanded(
              child: OutlinedButton(
                onPressed: onBack,
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  side: BorderSide(color: AppColor.borderColor(context)),
                ),
                child: Text(
                  AppLocaleKey.back.tr().toUpperCase(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                    color: AppColor.whiteColor(context).withValues(alpha: 0.7),
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          if (currentStep > 0) Gap(16.w),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: onNext,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                padding: EdgeInsets.symmetric(vertical: 20.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                elevation: 0,
                shadowColor: primary.withValues(alpha: 0.4),
              ),
              child: Text(
                nextLabel.toUpperCase(),
                style: AppTextStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.w900,
                  color: AppColor.whiteColor(context),
                  letterSpacing: 1.5,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
