import 'package:car/core/theme/app_colors.dart';
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
    final successColor = AppColor.greenColor(context);
    final errorColor = AppColor.redColor(context);

    return Container(
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: kpi.color.withOpacity(0.12)),
        boxShadow: [
          BoxShadow(
            color: kpi.color.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [kpi.color.withOpacity(0.15), kpi.color.withOpacity(0.05)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(color: kpi.color.withOpacity(0.2)),
                ),
                child: Icon(kpi.icon, color: kpi.color, size: 20.sp),
              ),
              const Spacer(),
              if (kpi.change != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: (isUp ? successColor : errorColor).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: (isUp ? successColor : errorColor).withOpacity(0.15),
                    ),
                  ),
                  child: Text(
                    '${isUp ? '↑' : '↓'} ${kpi.change!.abs().toStringAsFixed(0)}%',
                    style: TextStyle(
                      color: isUp ? successColor : errorColor,
                      fontSize: 11.sp,
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
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.w900,
              fontSize: 26.sp,
              height: 1.1,
              letterSpacing: -0.5,
            ),
          ),
          Gap(4.h),
          Text(
            kpi.label,
            style: TextStyle(
              color: AppColor.greyColor(context),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.2,
            ),
          ),
        ],
      ),
    );
  }
}
