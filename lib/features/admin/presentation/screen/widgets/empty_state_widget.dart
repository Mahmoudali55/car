import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.directions_car_outlined,
            size: 48.sp,
            color: AppColor.blackTextColor(context).withValues(alpha: 0.15),
          ),
          Gap(12.h),
          Text(
            AppLocaleKey.noCarsAvailable.tr(),
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.35),
            ),
          ),
        ],
      ),
    );
  }
}
