import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumTierBadge extends StatelessWidget {
  const PremiumTierBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AgentTheme.gold.withOpacity(0.15), AgentTheme.gold.withOpacity(0.05)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AgentTheme.gold.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AgentTheme.gold.withOpacity(0.15),
            blurRadius: 12.r,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, color: AgentTheme.gold, size: 14.sp),
          Gap(6.w),
          Text(
            'ذهبي',
            style: TextStyle(
              color: AgentTheme.gold,
              fontWeight: FontWeight.w900,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
