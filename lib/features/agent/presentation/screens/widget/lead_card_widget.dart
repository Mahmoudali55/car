

import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/status_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'action_btn.dart';

class LeadCard extends StatelessWidget {
  final AgentLead lead;
  const LeadCard({super.key, required this.lead});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 14.h),
      decoration: BoxDecoration(
        color: AgentTheme.card,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(14.w),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: lead.statusColor.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Center(
                    child: Text(
                      lead.customerName[0],
                      style: TextStyle(
                          color: lead.statusColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 20.sp),
                    ),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Expanded(
                          child: Text(lead.customerName,
                              style: TextStyle(
                                  color: AgentTheme.text1,
                                  fontWeight: FontWeight.w900,
                                  fontSize: 15.sp)),
                        ),
                        StatusBadge(lead: lead),
                      ]),
                      Gap(3.h),
                      Text(lead.carInterest,
                          style: TextStyle(
                              color: AgentTheme.text2, fontSize: 12.sp)),
                      Gap(3.h),
                      Text(
                        'الميزانية: ${NumberFormat('#,##0').format(lead.budget)} ر.س',
                        style: TextStyle(
                            color: AgentTheme.blue,
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Gap(12.h),

          Padding(
            padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
            child: Row(children: [
              ActionBtn(
                icon: Icons.phone_rounded,
                label: 'اتصال',
                color: AgentTheme.green,
                onTap: () =>
                    launchUrl(Uri.parse('tel:${lead.phoneNumber}')),
              ),
              Gap(8.w),
              ActionBtn(
                icon: Icons.chat_rounded,
                label: 'واتساب',
                color: const Color(0xFF25D366),
                onTap: () => launchUrl(Uri.parse(
                    'https://wa.me/966${lead.phoneNumber.substring(1)}')),
              ),
              Gap(8.w),
              ActionBtn(
                icon: Icons.schedule_rounded,
                label: 'موعد',
                color: const Color(0xFF9C27B0),
                onTap: () {},
              ),
            ]),
          ),
        ],
      ),
    );
  }
}