import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumKpiCard extends StatelessWidget {
  final AgentKpi kpi;
  const PremiumKpiCard({super.key, required this.kpi});

  @override
  Widget build(BuildContext context) {
    final isUp = (kpi.change ?? 0) > 0;
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AgentTheme.card,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: kpi.color.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: kpi.color.withOpacity(0.08),
            blurRadius: 12.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kpi.color.withOpacity(0.2), kpi.color.withOpacity(0.08)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: kpi.color.withOpacity(0.2)),
                ),
                child: Icon(kpi.icon, color: kpi.color, size: 18.sp),
              ),
              const Spacer(),
              if (kpi.change != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: (isUp ? AgentTheme.green : AgentTheme.red).withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: (isUp ? AgentTheme.green : AgentTheme.red).withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    '${isUp ? '↑' : '↓'} ${kpi.change!.abs().toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: isUp ? AgentTheme.green : AgentTheme.red,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          Text(
            kpi.value,
            style: TextStyle(
              color: AgentTheme.text1,
              fontWeight: FontWeight.w900,
              fontSize: 24.sp,
              height: 1.1,
            ),
          ),
          Gap(3.h),
          Text(
            kpi.label,
            style: TextStyle(
              color: AgentTheme.text2,
              fontSize: 11.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
