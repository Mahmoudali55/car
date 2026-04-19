import 'dart:ui';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationTimerBanner extends StatelessWidget {
  final String formattedTime;

  const ReservationTimerBanner({super.key, required this.formattedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.timer_outlined, color: AppColor.primaryColor(context)),
              Gap(8.w),
              Text(
                AppLocaleKey.timeRemaining.tr(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: AppColor.blackTextColor(context),
                ),
              ),
            ],
          ),
          Text(
            formattedTime,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              color: AppColor.primaryColor(context),
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
