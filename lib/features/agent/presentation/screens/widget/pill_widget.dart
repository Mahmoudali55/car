import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class Pill extends StatelessWidget {
  const Pill({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
    required this.iconColor,
  });

  final IconData icon;
  final String label;
  final Color bgColor, borderColor, textColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 13.sp),
          Gap(5.w),
          Text(
            label,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w700, fontSize: 12.sp),
          ),
        ],
      ),
    );
  }
}
