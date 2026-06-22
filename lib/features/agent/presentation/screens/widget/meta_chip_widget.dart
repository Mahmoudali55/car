import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MetaChip extends StatelessWidget {
  const MetaChip({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.fullWidth = false,
  });

  final IconData icon;
  final Color iconColor;
  final String label;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? double.infinity : null,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.15)),
      ),
      child: Row(
        mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
        children: [
          Icon(icon, color: iconColor, size: 14.sp),
          Gap(7.w),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.darkTextColor(context),
                fontWeight: FontWeight.w600,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
