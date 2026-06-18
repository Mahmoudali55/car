import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomInitialSearchWidget extends StatelessWidget {
  const CustomInitialSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.03),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.search_rounded,
              size: 50.sp,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
            ),
          ),
          Gap(16.h),
          Text(
            AppLocaleKey.search.tr(),
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
