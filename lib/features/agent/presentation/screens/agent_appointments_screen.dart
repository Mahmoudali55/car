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
      backgroundColor: AgentTheme.navy,
      appBar: AppBar(
        backgroundColor: AgentTheme.navy2,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text('المواعيد',
            style: TextStyle(color: AgentTheme.text1, fontWeight: FontWeight.w900, fontSize: 22.sp)),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(left: 16.w),
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                color: AgentTheme.blue.withOpacity(0.12),
                borderRadius: BorderRadius.circular(11.r),
                border: Border.all(color: AgentTheme.blue.withOpacity(0.25)),
              ),
              child: Icon(Icons.add_rounded, color: AgentTheme.blue, size: 20.sp),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
        children: [
          if (upcoming.isNotEmpty) ...[
            SectionHeader(title: 'القادمة', count: upcoming.length, color: AgentTheme.blue),
            Gap(12.h),
            ...upcoming.map((a) => AppointmentCard(
              appointment: a,
              onCheckIn: () => setState(() => a.status = AppointmentStatus.checkedIn),
              onDone: () => setState(() => a.status = AppointmentStatus.done),
              onCancel: () => setState(() => a.status = AppointmentStatus.cancelled),
            )),
            Gap(24.h),
          ],
          if (done.isNotEmpty) ...[
            SectionHeader(title: 'المنتهية', count: done.length, color: AgentTheme.text3),
            Gap(12.h),
            ...done.map((a) => AppointmentCard(appointment: a)),
          ],
        ],
      ),
    );
  }
}

// ── Section Header ────────────────────────────────────────────────────────────

// ── Appointment Card ──────────────────────────────────────────────────────────



