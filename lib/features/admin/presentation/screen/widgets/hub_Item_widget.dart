import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HubItemWidget extends StatelessWidget {
  const HubItemWidget({
    super.key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: (0.05)),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: color.withValues(alpha: (0.1))),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: color.withValues(alpha: (0.1)),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            Text(
              label,
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
