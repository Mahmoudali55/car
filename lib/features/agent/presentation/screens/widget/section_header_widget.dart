import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  const SectionHeader({super.key, required this.title, required this.count, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 3.w,
          height: 18.h,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2.r)),
        ),
        Gap(10.w),
        Text(title, style: TextStyle(color: AgentTheme.text1, fontWeight: FontWeight.w900, fontSize: 16.sp)),
        Gap(8.w),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text('$count', style: TextStyle(color: color, fontSize: 11.sp, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
