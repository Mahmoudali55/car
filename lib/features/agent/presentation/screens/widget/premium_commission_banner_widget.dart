import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/commission_stat_divider_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/commission_stat_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumCommissionBanner extends StatelessWidget {
  const PremiumCommissionBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final blueColor = AppColor.blueColor(context);
    final successColor = AppColor.greenColor(context);
    final goldColor = AppColor.goldColor(context);

    return Container(
      padding: EdgeInsets.all(22.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            blueColor,
            blueColor.withOpacity(0.85),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
        boxShadow: [
          BoxShadow(
            color: blueColor.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 10),
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
                    AppLocaleKey.agentCommissionThisMonth.tr(),
                    style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13.sp, fontWeight: FontWeight.w600),
                  ),
                  Gap(6.h),
                  Text(
                    '15,625 ${AppLocaleKey.agentCurrencySar.tr()}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.sp,
                      height: 1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Icon(Icons.trending_up_rounded, color: successColor, size: 26.sp),
              ),
            ],
          ),
          Gap(20.h),

          /// ── Progress bar ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocaleKey.agentProgressToGoal.tr(),
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.7), fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    AppLocaleKey.agentGoalProgressValue.tr(namedArgs: {'percent': '78', 'total': '20,000'}),
                    style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w900),
                  ),
                ],
              ),
              Gap(10.h),
              Stack(
                children: [
                  Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: 0.78,
                    child: Container(
                      height: 8.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withOpacity(0.3),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(24.h),

          /// ── Stats row ──
          Row(
            children: [
              CommissionStat(
                value: AppLocaleKey.agentRankValue.tr(namedArgs: {'rank': '3'}),
                label: AppLocaleKey.agentOutOfConsultants.tr(namedArgs: {'total': '24'}),
                color: Colors.white,
              ),
              const CommissionStatDivider(),
              CommissionStat(
                value: '41.2K ${AppLocaleKey.agentCurrencySar.tr()}',
                label: AppLocaleKey.agentTotalQuarter.tr(),
                color: Colors.white,
              ),
              const CommissionStatDivider(),
              CommissionStat(
                value: AppLocaleKey.agentLevelGold.tr(),
                label: AppLocaleKey.agentLevelLabel.tr(),
                color: goldColor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
