import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/model/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/quick_stat_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomQuickStatWidget extends StatelessWidget {
  const CustomQuickStatWidget({super.key, required this.todayAppts, required this.pendingLeads});

  final List<AgentAppointment> todayAppts;
  final List<AgentLead> pendingLeads;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickStat(
            icon: Icons.calendar_today_rounded,
            label: AppLocaleKey.agentAppointment.tr(),
            value: '${todayAppts.length}',
            color: AppColor.blueColor(context),
          ),
        ),
        Gap(8.w),
        Expanded(
          child: QuickStat(
            icon: Icons.person_add_rounded,
            label: AppLocaleKey.agentNew.tr(),
            value: '${pendingLeads.where((l) => l.status == LeadStatus.newLead).length}',
            color: AppColor.greenColor(context),
          ),
        ),
        Gap(8.w),
        Expanded(
          child: QuickStat(
            icon: Icons.trending_up_rounded,
            label: AppLocaleKey.agentPerformance.tr(),
            value: '87%',
            color: AppColor.orangeColor(context),
          ),
        ),
      ],
    );
  }
}
