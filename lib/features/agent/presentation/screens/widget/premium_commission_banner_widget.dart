import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/commission_stat_divider_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/commission_stat_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumCommissionBanner extends StatelessWidget {
  const PremiumCommissionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AgentTheme.blue2, Color(0xFF0A2080)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AgentTheme.blue.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: AgentTheme.blue.withOpacity(0.2),
            blurRadius: 20.r,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'عمولة هذا الشهر',
                    style: TextStyle(color: Colors.white70, fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                  Gap(6.h),
                  Text(
                    '15,625 ر.س',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 28.sp,
                      height: 1,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Icon(Icons.trending_up_rounded, color: AgentTheme.green, size: 24.sp),
              ),
            ],
          ),
          Gap(16.h),
          // Progress bar with label
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'التقدم نحو الهدف',
                    style: TextStyle(color: Colors.white60, fontSize: 11.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '78% من 20,000 ر.س',
                    style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Gap(8.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(6.r),
                child: LinearProgressIndicator(
                  value: 0.78,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 6.h,
                ),
              ),
            ],
          ),
          Gap(18.h),
          // Stats row
          const Row(
            children: [
              CommissionStat(value: 'المرتبة 3', label: 'من 24 مندوب', color: Colors.white),
              CommissionStatDivider(),
              CommissionStat(value: '41.2K ر.س', label: 'إجمالي الربع', color: Colors.white),
              CommissionStatDivider(),
              CommissionStat(value: 'ذهبي', label: 'المستوى', color: AgentTheme.gold),
            ],
          ),
        ],
      ),
    );
  }
}
