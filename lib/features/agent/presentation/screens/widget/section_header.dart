import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? trailing;
  final Color? trailingColor;
  const SectionHeader({super.key, required this.title, this.trailing, this.trailingColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 22.h,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AgentTheme.blue, Color(0xFF6C3EFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(3.r),
          ),
        ),
        Gap(12.w),
        Text(
          title,
          style: TextStyle(
            color: AgentTheme.text1,
            fontWeight: FontWeight.w900,
            fontSize: 17.sp,
            height: 1.2,
          ),
        ),
        const Spacer(),
        if (trailing != null)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: (trailingColor ?? AgentTheme.text3).withOpacity(0.12),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: (trailingColor ?? AgentTheme.text3).withOpacity(0.2),
              ),
            ),
            child: Text(
              trailing!,
              style: TextStyle(
                color: trailingColor ?? AgentTheme.text2,
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
      ],
    );
  }
}