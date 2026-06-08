import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CalculatorBanner extends StatelessWidget {
  final VoidCallback onTap;

  const CalculatorBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColor.primaryColor(context).withValues(alpha: 0.9),
              AppColor.primaryColor(context),
            ],
          ),
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Row(
          children: [
            Icon(Icons.calculate_outlined, color: AppColor.whiteColor(context), size: 24.sp),
            Gap(12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppLocaleKey.agentCalculateFinancingAmount.tr(),
                    style: AppTextStyle.bodyLarge(context).copyWith(
                      color: AppColor.whiteColor(context),
                      fontWeight: FontWeight.w900,
                      fontSize: 14.sp,
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    AppLocaleKey.agentKnowMonthlyInstallment.tr(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.whiteColor(context).withValues(alpha: 0.7),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
