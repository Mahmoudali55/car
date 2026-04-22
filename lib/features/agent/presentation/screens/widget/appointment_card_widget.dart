import 'package:car/core/theme/app_colors.dart';
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

  Color _getStatusColor(BuildContext context) {
    switch (appointment.status) {
      case AppointmentStatus.upcoming:
        return AppColor.blueColor(context);
      case AppointmentStatus.checkedIn:
        return AppColor.greenColor(context);
      case AppointmentStatus.done:
        return AppColor.hintColor(context);
      case AppointmentStatus.cancelled:
        return AppColor.redColor(context);
    }
  }

  String get _statusLabel {
    switch (appointment.status) {
      case AppointmentStatus.upcoming:
        return 'قادم';
      case AppointmentStatus.checkedIn:
        return 'تم الحضور';
      case AppointmentStatus.done:
        return 'منتهي';
      case AppointmentStatus.cancelled:
        return 'ملغي';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(context);
    final timeF = DateFormat('hh:mm a');
    final dateF = DateFormat('EEE، d MMM');
    final isPast = appointment.status == AppointmentStatus.done || appointment.status == AppointmentStatus.cancelled;

    return Opacity(
      opacity: isPast ? 0.6 : 1.0,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: AppColor.borderColor(context).withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
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
                  /// ── Time badge ──
                  Container(
                    width: 70.w,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [statusColor.withOpacity(0.12), statusColor.withOpacity(0.04)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: statusColor.withOpacity(0.15)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          timeF.format(appointment.dateTime),
                          style: TextStyle(color: statusColor, fontWeight: FontWeight.w900, fontSize: 13.sp),
                          textAlign: TextAlign.center,
                        ),
                        Gap(2.h),
                        Text(
                          dateF.format(appointment.dateTime),
                          style: TextStyle(
                            color: statusColor.withOpacity(0.7),
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Gap(16.w),

                  /// ── Customer & Details ──
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                appointment.customerName,
                                style: TextStyle(
                                  color: AppColor.blackTextColor(context),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16.sp,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(color: statusColor.withOpacity(0.15)),
                              ),
                              child: Text(
                                _statusLabel,
                                style: TextStyle(color: statusColor, fontSize: 11.sp, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                        Gap(6.h),
                        Text(
                          appointment.carModel,
                          style: TextStyle(
                            color: AppColor.greyColor(context),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Gap(6.h),
                        Row(
                          children: [
                            Icon(Icons.location_on_rounded, size: 13.sp, color: AppColor.hintColor(context)),
                            Gap(4.w),
                            Text(
                              appointment.location,
                              style: TextStyle(
                                color: AppColor.hintColor(context),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            /// ── Action buttons ──
            if (!isPast)
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: Row(
                  children: [
                    if (appointment.status == AppointmentStatus.upcoming)
                      Expanded(
                        child: ActionBtn(
                          label: 'تسجيل الحضور',
                          icon: Icons.check_circle_rounded,
                          color: AppColor.greenColor(context),
                          onTap: onCheckIn ?? () {},
                        ),
                      ),
                    if (appointment.status == AppointmentStatus.checkedIn)
                      Expanded(
                        child: ActionBtn(
                          label: 'إتمام الموعد',
                          icon: Icons.task_alt_rounded,
                          color: AppColor.blueColor(context),
                          onTap: onDone ?? () {},
                        ),
                      ),
                    if (appointment.status == AppointmentStatus.upcoming ||
                        appointment.status == AppointmentStatus.checkedIn)
                      Gap(10.w),
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
