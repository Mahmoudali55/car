import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/commission_stat_divider_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/commission_stat_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_progress_bar_widget.dart';
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
          colors: [blueColor, blueColor.withValues(alpha: 0.85)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColor.whiteColor(context).withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: blueColor.withValues(alpha: 0.3),
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
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: AppColor.whiteColor(context).withValues(alpha: 0.8),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(6.h),
                  Text(
                    '15,625 ${AppLocaleKey.agentCurrencySar.tr()}',
                    style: AppTextStyle.titleLarge(context).copyWith(
                      color: AppColor.whiteColor(context),
                      fontWeight: FontWeight.w900,
                      height: 1,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: AppColor.whiteColor(context).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(18.r),
                  border: Border.all(color: AppColor.whiteColor(context).withValues(alpha: 0.2)),
                ),
                child: Icon(Icons.trending_up_rounded, color: successColor, size: 26.sp),
              ),
            ],
          ),
          Gap(20.h),
          const CustomProgressBarWidget(),
          Gap(24.h),
          Row(
            children: [
              CommissionStat(
                value: AppLocaleKey.agentRankValue.tr(namedArgs: {'rank': '3'}),
                label: AppLocaleKey.agentOutOfConsultants.tr(namedArgs: {'total': '24'}),
                color: AppColor.whiteColor(context),
              ),
              const CommissionStatDivider(),
              CommissionStat(
                value: '41.2K ${AppLocaleKey.agentCurrencySar.tr()}',
                label: AppLocaleKey.agentTotalQuarter.tr(),
                color: AppColor.whiteColor(context),
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
