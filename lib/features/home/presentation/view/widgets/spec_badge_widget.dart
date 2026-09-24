import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SpecBadgeWidget extends StatelessWidget {
  const SpecBadgeWidget({
    super.key,
    required this.text,
    this.icon,
    this.customIcon,
  });

  final String text;
  final IconData? icon;
  final Widget? customIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (customIcon != null)
            customIcon!
          else if (icon != null)
            Icon(icon, color: AppColor.blackTextColor(context).withValues(alpha: 0.54), size: 14.sp),
          Gap(6.w),
          Text(
            text,
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
