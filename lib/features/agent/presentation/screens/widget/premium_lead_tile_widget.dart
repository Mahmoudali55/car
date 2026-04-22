import 'package:car/features/agent/data/agent_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class PremiumLeadTile extends StatelessWidget {
  final AgentLead lead;
  const PremiumLeadTile({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AgentTheme.card,
        borderRadius: BorderRadius.circular(20.r),
        border: Border(
          right: BorderSide(color: lead.statusColor, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: lead.statusColor.withOpacity(0.08),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [lead.statusColor.withOpacity(0.2), lead.statusColor.withOpacity(0.08)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: lead.statusColor.withOpacity(0.2)),
            ),
            child: Center(
              child: Text(
                lead.customerName[0],
                style: TextStyle(
                  color: lead.statusColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 17.sp,
                ),
              ),
            ),
          ),
          Gap(14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead.customerName,
                  style: TextStyle(
                    color: AgentTheme.text1,
                    fontWeight: FontWeight.w900,
                    fontSize: 14.sp,
                  ),
                ),
                Gap(3.h),
                Text(
                  lead.carInterest,
                  style: TextStyle(color: AgentTheme.text2, fontSize: 12.sp, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: lead.statusColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: lead.statusColor.withOpacity(0.2)),
                ),
                child: Text(
                  lead.statusLabel,
                  style: TextStyle(
                    color: lead.statusColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Gap(6.h),
              Text(
                '${NumberFormat('#,##0').format(lead.budget)} ر.س',
                style: TextStyle(
                  color: AgentTheme.text2,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
