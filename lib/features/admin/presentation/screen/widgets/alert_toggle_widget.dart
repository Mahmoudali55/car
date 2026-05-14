import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AlertToggleWidget extends StatelessWidget {
  const AlertToggleWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.initialValue,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final bool initialValue;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: (0.03)),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: baseColor.withValues(alpha: (0.05))),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          leading: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: baseColor.withValues(alpha: (0.05)),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: baseColor, size: 22.sp),
          ),
          title: Text(
            title,
            style: TextStyle(color: baseColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: baseColor.withValues(alpha: (0.4)),
              fontSize: 11.sp,
            ),
          ),
          trailing: Switch(
            value: initialValue,
            onChanged: (val) {},
            activeTrackColor: AppColor.primaryColor(context).withValues(alpha: (0.3)),
            activeThumbColor: AppColor.primaryColor(context),
          ),
        ),
      ),
    );
  }
}
