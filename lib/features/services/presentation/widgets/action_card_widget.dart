import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ActionCardWidget extends StatelessWidget {
  const ActionCardWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.bgColor,
    required this.iconColor,
    required this.onTap,
  });
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    final isDark = !AppColor.isLight(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isDark ? AppColor.secondAppColor(context) : bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: isDark ? AppColor.borderColor(context) : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor(context).withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isDark ? iconColor.withValues(alpha: 0.1) : iconColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            Gap(12.h),
            Text(
              title,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: isDark ? AppColor.blackTextColor(context) : iconColor.withValues(alpha: 0.2),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
