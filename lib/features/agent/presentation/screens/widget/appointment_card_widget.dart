import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/action_btn_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/cancel_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppointmentCard extends StatelessWidget {
  final AgentAppointment appointment;
  final VoidCallback? onCheckIn;
  final VoidCallback? onDone;
  final VoidCallback? onCancel;

  const AppointmentCard({
    required this.appointment,
    this.onCheckIn,
    this.onDone,
    this.onCancel,
  });

  Color get _statusColor {
    switch (appointment.status) {
      case AppointmentStatus.upcoming:  return AgentTheme.blue;
      case AppointmentStatus.checkedIn: return AgentTheme.green;
      case AppointmentStatus.done:      return AgentTheme.text3;
      case AppointmentStatus.cancelled: return AgentTheme.red;
    }
  }

  String get _statusLabel {
    switch (appointment.status) {
      case AppointmentStatus.upcoming:  return 'قادم';
      case AppointmentStatus.checkedIn: return 'تم الحضور';
      case AppointmentStatus.done:      return 'منتهي';
      case AppointmentStatus.cancelled: return 'ملغي';
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeF = DateFormat('hh:mm a');
    final dateF = DateFormat('EEE، d MMM');
    final isPast = appointment.status == AppointmentStatus.done ||
        appointment.status == AppointmentStatus.cancelled;

    return Opacity(
      opacity: isPast ? 0.5 : 1.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 14.h),
        decoration: BoxDecoration(
          color: AgentTheme.card,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: _statusColor.withOpacity(0.2)),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(14.w),
              child: Row(
                children: [
                  // Time badge
                  Container(
                    width: 62.w,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: _statusColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: _statusColor.withOpacity(0.2)),
                    ),
                    child: Column(
                      children: [
                        Text(timeF.format(appointment.dateTime),
                            style: TextStyle(
                                color: _statusColor, fontWeight: FontWeight.w900, fontSize: 11.sp),
                            textAlign: TextAlign.center),
                        Gap(2.h),
                        Text(dateF.format(appointment.dateTime),
                            style: TextStyle(color: _statusColor.withOpacity(0.6), fontSize: 8.sp),
                            textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  Gap(14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          Expanded(
                            child: Text(appointment.customerName,
                                style: TextStyle(
                                    color: AgentTheme.text1, fontWeight: FontWeight.w900, fontSize: 15.sp)),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: _statusColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(7.r),
                            ),
                            child: Text(_statusLabel,
                                style: TextStyle(color: _statusColor, fontSize: 10.sp, fontWeight: FontWeight.bold)),
                          ),
                        ]),
                        Gap(4.h),
                        Text(appointment.carModel,
                            style: TextStyle(color: AgentTheme.text2, fontSize: 12.sp)),
                        Gap(4.h),
                        Row(children: [
                          Icon(Icons.location_on_rounded, size: 12.sp, color: AgentTheme.text3),
                          Gap(3.w),
                          Text(appointment.location,
                              style: TextStyle(color: AgentTheme.text3, fontSize: 11.sp)),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Action buttons
            if (!isPast)
              Padding(
                padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
                child: Row(
                  children: [
                    if (appointment.status == AppointmentStatus.upcoming)
                      Expanded(
                        child: ActionBtn(
                          label: 'تسجيل الحضور',
                          icon: Icons.check_circle_outline_rounded,
                          color: AgentTheme.green,
                          onTap: onCheckIn ?? () {},
                        ),
                      ),
                    if (appointment.status == AppointmentStatus.checkedIn)
                      Expanded(
                        child: ActionBtn(
                          label: 'إتمام الموعد',
                          icon: Icons.task_alt_rounded,
                          color: AgentTheme.blue,
                          onTap: onDone ?? () {},
                        ),
                      ),
                    if (appointment.status == AppointmentStatus.upcoming ||
                        appointment.status == AppointmentStatus.checkedIn)
                      Gap(8.w),
                    CancelBtn(onTap: onCancel ?? () {}),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
