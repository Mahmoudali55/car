// ─── ad_tag_widget.dart ──────────────────────────────────────────

import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdTagWidget extends StatelessWidget {
  final String tag;
  final Color accentColor;

  const AdTagWidget({super.key, required this.tag, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: accentColor.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: accentColor.withValues(alpha: 0.35), width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5.w,
            height: 5.w,
            decoration: BoxDecoration(color: accentColor, shape: BoxShape.circle),
          ),
          Gap(5.w),
          Text(
            tag,
            style: AppTextStyle.bodySmall(context).copyWith(
              color: accentColor,
              fontSize: 9.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}
