import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';

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
    final statusColor = lead.getStatusColor(context);

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColor.borderColor(context).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                /// ── Avatar ──
                Container(
                  width: 52.w,
                  height: 52.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [statusColor.withOpacity(0.15), statusColor.withOpacity(0.05)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: statusColor.withOpacity(0.2)),
                  ),
                  child: Center(
                    child: Text(
                      lead.customerName[0],
                      style: TextStyle(color: statusColor, fontWeight: FontWeight.w900, fontSize: 22.sp),
                    ),
                  ),
                ),
                Gap(14.w),

                /// ── Info ──
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              lead.customerName,
                              style: TextStyle(
                                color: AppColor.blackTextColor(context),
                                fontWeight: FontWeight.w900,
                                fontSize: 16.sp,
                                letterSpacing: -0.3,
                              ),
                            ),
                          ),
                          StatusBadge(lead: lead),
                        ],
                      ),
                      Gap(4.h),
                      Text(
                        lead.carInterest,
                        style: TextStyle(
                          color: AppColor.greyColor(context),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(6.h),
                      Text(
                        AppLocaleKey.agentBudgetDisplay.tr(namedArgs: {'amount': NumberFormat('#,##0').format(lead.budget)}),
                        style: TextStyle(
                          color: AppColor.blueColor(context),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// ── Actions ──
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              spacing:  5.w,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                
              children: [
                Expanded(
                  child: ActionBtn(
                    icon: Icons.phone_rounded,
                    label: AppLocaleKey.agentCall.tr(),
                    color: AppColor.greenColor(context),
                    onTap: () => launchUrl(Uri.parse('tel:${lead.phoneNumber}')),
                  ),
                ),
                
                Expanded(
                  child: ActionBtn(
                    icon: Icons.chat_rounded,
                    label: AppLocaleKey.agentWhatsapp.tr(),
                    color: const Color(0xFF25D366),
                    onTap: () => launchUrl(Uri.parse('https://wa.me/966${lead.phoneNumber.substring(1)}')),
                  ),
                ),
                
                Expanded(
                  child: ActionBtn(
                    icon: Icons.schedule_rounded,
                    label: AppLocaleKey.agentAppointmentButtonLabel.tr(),
                    color: const Color(0xFF9C27B0),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}