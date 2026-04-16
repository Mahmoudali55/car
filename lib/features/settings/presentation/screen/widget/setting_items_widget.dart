import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingItemsWidget extends StatelessWidget {
  const SettingItemsWidget ({super.key, required this.icon, required this.title, this.trailing, required this.onTap,});
    final IconData icon;final String title;final Widget? trailing;final VoidCallback onTap;

  @override

  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return Container(
      decoration: BoxDecoration(
        color: baseColor.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: baseColor.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        leading: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColor.primaryColor(context).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColor.primaryColor(context), size: 22.sp),
        ),
        title: Text(
          title,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: baseColor, fontWeight: FontWeight.w500),
        ),
        trailing:
            trailing ??
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: baseColor.withValues(alpha: 0.24),
              size: 14.sp,
            ),
      ),
    );
  }
}