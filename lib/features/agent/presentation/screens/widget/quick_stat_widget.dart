import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class QuickStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const QuickStat({super.key, 
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 11.sp, color: color),
          Gap(6.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: AgentTheme.text3, fontSize: 9.sp, fontWeight: FontWeight.w600)),
              Text(value, style: TextStyle(color: color, fontSize: 11.sp, fontWeight: FontWeight.w900)),
            ],
          ),
        ],
      ),
    );
  }
}