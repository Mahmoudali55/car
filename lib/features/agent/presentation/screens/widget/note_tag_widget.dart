import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoteTag extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  const NoteTag({super.key, required this.label, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? color : color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withValues(alpha: isSelected ? 1 : 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: AppTextStyle.bodySmall(context).copyWith(
              color: isSelected ? AppColor.whiteColor(context) : color,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
