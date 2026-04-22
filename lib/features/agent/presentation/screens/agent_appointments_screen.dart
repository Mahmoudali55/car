import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/appointment_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class AgentAppointmentsScreen extends StatefulWidget {
  const AgentAppointmentsScreen({super.key});

  @override
  State<AgentAppointmentsScreen> createState() => _AgentAppointmentsScreenState();
}

class _AgentAppointmentsScreenState extends State<AgentAppointmentsScreen> {
  late List<AgentAppointment> _appointments;

  @override
  void initState() {
    super.initState();
    _appointments = List.from(kAgentAppointments);
  }

  @override
  Widget build(BuildContext context) {
    final upcoming = _appointments
        .where((a) => a.status == AppointmentStatus.upcoming || a.status == AppointmentStatus.checkedIn)
        .toList();
    final done = _appointments
        .where((a) => a.status == AppointmentStatus.done || a.status == AppointmentStatus.cancelled)
        .toList();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor(context),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: false,
        toolbarHeight: 70.h,
        title: Text(
          'المواعيد',
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
              title: 'المواعيد القادمة',
              count: upcoming.length,
              color: AppColor.blueColor(context),
            ),
            Gap(16.h),
            ...upcoming.map((a) => AppointmentCard(
                  appointment: a,
                  onCheckIn: () => setState(() => a.status = AppointmentStatus.checkedIn),
                  onDone: () => setState(() => a.status = AppointmentStatus.done),
                  onCancel: () => setState(() => a.status = AppointmentStatus.cancelled),
                )),
            Gap(30.h),
          ],
          if (done.isNotEmpty) ...[
            SectionHeader(
              title: 'السجل السابق',
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
                    Icon(Icons.calendar_today_outlined, size: 60.sp, color: AppColor.hintColor(context).withOpacity(0.3)),
                    Gap(16.h),
                    Text(
                      'لا توجد مواعيد حالياً',
                      style: TextStyle(color: AppColor.hintColor(context), fontSize: 16.sp, fontWeight: FontWeight.w600),
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

// ── Section Header ────────────────────────────────────────────────────────────

// ── Appointment Card ──────────────────────────────────────────────────────────



