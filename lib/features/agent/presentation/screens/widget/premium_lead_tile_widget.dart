import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumLeadTile extends StatelessWidget {
  final AgentLead lead;
  const PremiumLeadTile({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    final statusColor = lead.getStatusColor(context);

    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: 0.04),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          /// ── Avatar ──
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [statusColor.withValues(alpha: 0.15), statusColor.withValues(alpha: 0.05)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: statusColor.withValues(alpha: 0.2)),
            ),
            child: Center(
              child: Text(
                lead.customerName[0],
                style: AppTextStyle.bodyMedium(
                  context,
                ).copyWith(color: statusColor, fontWeight: FontWeight.w900, fontSize: 20.sp),
              ),
            ),
          ),
          Gap(16.w),

          /// ── Details ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead.customerName,
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w900,
                    fontSize: 15.sp,
                    letterSpacing: -0.2,
                  ),
                ),
                Gap(4.h),
                Text(
                  lead.carInterest,
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.greyColor(context),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          /// ── Trailing ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: statusColor.withValues(alpha: 0.15)),
                ),
                child: Text(
                  lead.statusLabel,
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: statusColor, fontWeight: FontWeight.w800),
                ),
              ),
              Gap(8.h),
              ValueWithCurrencyIcon(
                text: '${NumberFormat('#,##0').format(lead.budget)} ${AppLocaleKey.sar.tr()}',
                textStyle: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.blackTextColor(context),
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.3,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
