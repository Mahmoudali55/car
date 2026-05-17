import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomProgressBarWidget extends StatelessWidget {
  const CustomProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocaleKey.agentProgressToGoal.tr(),
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: AppColor.whiteColor(context).withValues(alpha: 0.7),
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              AppLocaleKey.agentGoalProgressValue.tr(
                namedArgs: {'percent': '78', 'total': '20,000'},
              ),
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: AppColor.whiteColor(context),
                fontSize: 12.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
        Gap(10.h),
        Stack(
          children: [
            Container(
              height: 8.h,
              decoration: BoxDecoration(
                color: AppColor.whiteColor(context).withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.78,
              child: Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: AppColor.whiteColor(context),
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.whiteColor(context).withValues(alpha: 0.3),
                      blurRadius: 6,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
