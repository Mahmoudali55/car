import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumWeeklyChart extends StatelessWidget {
  final List<int> data;
  final List<String> days;
  const PremiumWeeklyChart({super.key, required this.data, required this.days});

  @override
  Widget build(BuildContext context) {
    final maxVal = data.reduce((a, b) => a > b ? a : b);
    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AgentTheme.card,
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AgentTheme.border),
        boxShadow: [
          BoxShadow(
            color: AgentTheme.blue.withOpacity(0.06),
            blurRadius: 12.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المبيعات المتعاقدة',
                style: TextStyle(
                  color: AgentTheme.text1,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
              Text(
                'هذا الأسبوع',
                style: TextStyle(
                  color: AgentTheme.text3,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(data.length, (i) {
              final isPeak = data[i] == maxVal;
              final barH = (data[i] / maxVal * 90.h).clamp(12.0, 90.0);
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isPeak)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
                      margin: EdgeInsets.only(bottom: 4.h),
                      decoration: BoxDecoration(
                        color: AgentTheme.gold,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Text(
                        '${data[i]}',
                        style: TextStyle(
                          color: AgentTheme.navy,
                          fontWeight: FontWeight.w900,
                          fontSize: 10.sp,
                        ),
                      ),
                    )
                  else
                    SizedBox(height: 20.h),
                  Container(
                    width: 32.w,
                    height: barH,
                    decoration: BoxDecoration(
                      gradient: isPeak
                          ? const LinearGradient(
                              colors: [AgentTheme.blue, Color(0xFF6C3EFF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            )
                          : null,
                      color: isPeak ? null : AgentTheme.blue.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: isPeak
                          ? [
                              BoxShadow(
                                color: AgentTheme.blue.withOpacity(0.3),
                                blurRadius: 8.r,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    days[i],
                    style: TextStyle(
                      color: AgentTheme.text3,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
