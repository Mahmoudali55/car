import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/appointment_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentAppointmentsScreen extends StatefulWidget {
  const AgentAppointmentsScreen({super.key});
  @override
  State<AgentAppointmentsScreen> createState() => _AgentAppointmentsScreenState();
}

class _AgentAppointmentsScreenState extends State<AgentAppointmentsScreen> {
  @override
  Widget build(BuildContext context) {
    final appointments = getAgentAppointments();
    final upcoming = appointments
        .where(
          (a) => a.status == AppointmentStatus.upcoming || a.status == AppointmentStatus.checkedIn,
        )
        .toList();
    final done = appointments
        .where((a) => a.status == AppointmentStatus.done || a.status == AppointmentStatus.cancelled)
        .toList();
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        elevation: 0,
        title: Text(
          AppLocaleKey.agentAppointment.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 24.sp,
            letterSpacing: -0.5,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
        physics: const BouncingScrollPhysics(),
        children: [
          if (upcoming.isNotEmpty) ...[
            SectionHeader(
              title: AppLocaleKey.agentUpcomingAppointments.tr(),
              count: upcoming.length,
              color: AppColor.blueColor(context),
            ),
            Gap(16.h),
            ...upcoming.map(
              (a) => AppointmentCard(
                appointment: a,
                onCheckIn: () => setState(() => a.status = AppointmentStatus.checkedIn),
                onDone: () => setState(() => a.status = AppointmentStatus.done),
                onCancel: () => setState(() => a.status = AppointmentStatus.cancelled),
              ),
            ),
            Gap(30.h),
          ],
          if (done.isNotEmpty) ...[
            SectionHeader(
              title: AppLocaleKey.agentPreviousHistory.tr(),
              count: done.length,
              color: AppColor.hintColor(context),
            ),
            Gap(16.h),
            ...done.map((a) => AppointmentCard(appointment: a)),
          ],
          if (upcoming.isEmpty && done.isEmpty)
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100.h),
                child: Column(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 60.sp,
                      color: AppColor.hintColor(context).withOpacity(0.3),
                    ),
                    Gap(16.h),
                    Text(
                      AppLocaleKey.agentNoAppointmentsNow.tr(),
                      style: TextStyle(
                        color: AppColor.hintColor(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
