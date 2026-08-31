import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyNotificationState extends StatelessWidget {
  const EmptyNotificationState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_rounded,
            size: 64.sp,
            color: AppColor.greyColor(context).withValues(alpha: 0.4),
          ),
          Gap(16.h),
          Text(
            AppLocaleKey.agentNoNewNotifications.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.w600),
          ),
          Gap(8.h),
          Text(
            AppLocaleKey.agentNotifications.tr(),
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: AppColor.greyColor(context).withValues(alpha: 0.7)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
