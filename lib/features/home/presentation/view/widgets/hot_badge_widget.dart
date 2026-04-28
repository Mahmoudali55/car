import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HotBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      width: 70.w,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: (0.2)),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: (0.5))),
      ),
      child: Text(
        AppLocaleKey.mostRequested.tr(),
        style: AppTextStyle.bodySmall(context).copyWith(
          color: AppColor.blackTextColor(context),
          fontSize: 9.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
