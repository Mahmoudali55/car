import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecurityItemWidget extends StatelessWidget {
  const SecurityItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.isSwitch = false,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final bool isSwitch;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: baseColor.withOpacity(0.05)),
        ),
        child: ListTile(
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          leading: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: baseColor.withOpacity(0.05),
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
            style: TextStyle(color: baseColor.withOpacity(0.4), fontSize: 11.sp),
          ),
          trailing: isSwitch
              ? Switch(
                  value: true,
                  onChanged: (val) {},
                  activeColor: AppColor.primaryColor(context),
                )
              : Icon(Icons.chevron_left_rounded, color: baseColor.withOpacity(0.2)),
        ),
      ),
    );
  }
}
