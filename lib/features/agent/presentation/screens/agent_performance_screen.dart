import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:car/features/agent/presentation/screens/widget/comm_row_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/funnel_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentPerformanceScreen extends StatelessWidget {
  const AgentPerformanceScreen({super.key});

  // Mock weekly data
  static const _weeklyData = [4, 6, 3, 8, 5, 7, 4];
  static const _maxBar = 10;

  @override
  Widget build(BuildContext context) {
    final weekDays = [
      AppLocaleKey.sat.tr(),
      AppLocaleKey.sun.tr(),
      AppLocaleKey.mon.tr(),
      AppLocaleKey.tue.tr(),
      AppLocaleKey.wed.tr(),
      AppLocaleKey.thu.tr(),
      AppLocaleKey.fri.tr()
    ];
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        centerTitle: false,
        title: Text(AppLocaleKey.agentPerformanceStats.tr(),
            style: TextStyle(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900, fontSize: 20.sp)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context), size: 18.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.blueColor(context),
                    AppColor.blueColor(context).withValues(alpha: 0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blueColor(context).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.whiteColor(context).withValues(alpha: 0.2),
                      border: Border.all(color: AppColor.whiteColor(context).withValues(alpha: 0.4), width: 2),
                    ),
                    child: Icon(Icons.star_rounded, color: AppColor.goldColor(context), size: 32.sp),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(AppLocaleKey.agentTierGold.tr(),
                            style: TextStyle(color: AppColor.whiteColor(context), fontWeight: FontWeight.w900, fontSize: 20.sp)),
                        Text(AppLocaleKey.agentRankCount.tr(namedArgs: {'rank': '3', 'total': '24'}),
                            style: TextStyle(color: AppColor.whiteColor(context).withValues(alpha: 0.8), fontSize: 12.sp, fontWeight: FontWeight.w600)),
                        Gap(10.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: LinearProgressIndicator(
                            value: 0.72,
                            backgroundColor: AppColor.whiteColor(context).withValues(alpha: 0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(AppColor.goldColor(context)),
                            minHeight: 8.h,
                          ),
                        ),
                        Gap(6.h),
                        Text(AppLocaleKey.agentToPlatinum.tr(namedArgs: {'percent': '72'}),
                            style: TextStyle(color: AppColor.whiteColor(context).withValues(alpha: 0.6), fontSize: 10.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),
            Text(AppLocaleKey.agentWeeklyPerformance.tr(),
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: AppColor.blackTextColor(context))),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(color: AppColor.blackTextColor(context).withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 5))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (i) {
                  final h = (_weeklyData[i] / _maxBar * 110.h).clamp(15.0, 110.0);
                  final isMax = _weeklyData[i] == _weeklyData.reduce((a, b) => a > b ? a : b);
                  return Column(
                    children: [
                      if (isMax)
                        Container(
                          margin: EdgeInsets.only(bottom: 6.h),
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              color: AppColor.goldColor(context), borderRadius: BorderRadius.circular(8.r)),
                          child: Text('${_weeklyData[i]}',
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w900, color: AppColor.whiteColor(context))),
                        )
                      else
                        Gap(24.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        width: 34.w,
                        height: h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isMax
                                ? [AppColor.blueColor(context), AppColor.blueColor(context).withValues(alpha: 0.7)]
                                : [AppColor.blueColor(context).withValues(alpha: 0.2), AppColor.blueColor(context).withValues(alpha: 0.1)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      Gap(10.h),
                      Text(weekDays[i],
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.hintColor(context),
                              fontWeight: FontWeight.w700)),
                    ],
                  );
                }),
              ),
            ),
            Gap(32.h),

            // ── Conversion Funnel ──────────────────────────────────────────
            Text(AppLocaleKey.agentConversionFunnel.tr(),
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: AppColor.blackTextColor(context))),
            Gap(16.h),
            FunnelRow(label: AppLocaleKey.agentLeadsPotential.tr(), count: 32, total: 32, color: AppColor.blueColor(context)),
            Gap(10.h),
            FunnelRow(label: AppLocaleKey.agentVisitsOffers.tr(), count: 18, total: 32, color: const Color(0xFF8B5CF6)),
            Gap(10.h),
            FunnelRow(label: AppLocaleKey.agentClosedDeals.tr(), count: 7, total: 32, color: AppColor.greenColor(context)),
            Gap(32.h),

            // ── Commission ─────────────────────────────────────────────────
            Text(AppLocaleKey.agentCommissionsSales.tr(),
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: AppColor.blackTextColor(context))),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.5)),
                boxShadow: [
                  BoxShadow(color: AppColor.blackTextColor(context).withValues(alpha: 0.03), blurRadius: 15, offset: const Offset(0, 5))
                ],
              ),
              child: Column(
                children: [
                  CommRow(label: AppLocaleKey.agentCommissionThisMonth.tr(), value: '15,625 ${AppLocaleKey.sar.tr()}', color: AppColor.greenColor(context)),
                  Divider(height: 32.h, color: AppColor.borderColor(context)),
                  CommRow(label: AppLocaleKey.agentTotalQuarter.tr(), value: '41,200 ${AppLocaleKey.sar.tr()}', color: AppColor.blueColor(context)),
                  Divider(height: 32.h, color: AppColor.borderColor(context)),
                  CommRow(label: AppLocaleKey.agentMonthTarget.tr(), value: '20,000 ${AppLocaleKey.sar.tr()}', color: AppColor.hintColor(context)),
                ],
              ),
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }
}



