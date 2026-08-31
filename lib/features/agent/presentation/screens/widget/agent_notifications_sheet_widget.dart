import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/agent_notification_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/empty_state_notification_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/full_notification_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentNotificationsSheet extends StatefulWidget {
  final VoidCallback onChanged;
  const AgentNotificationsSheet({super.key, required this.onChanged});

  @override
  State<AgentNotificationsSheet> createState() => AgentNotificationsSheetState();
}

class AgentNotificationsSheetState extends State<AgentNotificationsSheet> {
  List<AgentNotification> get _notifications => agentNotifications.where((n) => !n.isRead).toList();

  void _approve(AgentNotification notif) {
    setState(() {
      final idx = agentNotifications.indexWhere((n) => n.id == notif.id);
      if (idx != -1) agentNotifications[idx].isRead = true;
    });
    widget.onChanged();
    _showSnack('تمت الموافقة على الإشعار بنجاح ✓', AppColor.greenColor(context));
  }

  void _reject(AgentNotification notif) {
    setState(() => agentNotifications.removeWhere((n) => n.id == notif.id));
    widget.onChanged();
    _showSnack('تم رفض الإشعار', AppColor.redColor(context));
  }

  void _showSnack(String msg, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldBg = AppColor.scaffoldColor(context);
    final cardBg = AppColor.cardColor(context);
    final blue = AppColor.blueColor(context);
    final pending = _notifications;

    return DraggableScrollableSheet(
      initialChildSize: 0.65,
      minChildSize: 0.4,
      maxChildSize: 0.92,
      builder: (context, scrollCtrl) {
        return Container(
          decoration: BoxDecoration(
            color: scaffoldBg,
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 24,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Handle
              Padding(
                padding: EdgeInsets.only(top: 12.h, bottom: 4.h),
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: AppColor.greyColor(context).withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),

              // Header
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 0),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [blue, blue.withValues(alpha: 0.6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.notifications_rounded, color: Colors.white, size: 20.sp),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'جميع الإشعارات',
                            style: AppTextStyle.titleMedium(context).copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackTextColor(context),
                            ),
                          ),
                          Text(
                            pending.isEmpty
                                ? 'لا توجد إشعارات'
                                : '${pending.length} إشعار يحتاج ردّك',
                            style: AppTextStyle.bodySmall(
                              context,
                            ).copyWith(color: AppColor.greyColor(context)),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'إغلاق',
                        style: AppTextStyle.bodySmall(context).copyWith(color: blue),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                height: 24.h,
                thickness: 1,
                indent: 20.w,
                endIndent: 20.w,
                color: AppColor.dividerColor(context),
              ),

              // List
              Expanded(
                child: pending.isEmpty
                    ? const EmptyNotificationState()
                    : ListView.separated(
                        controller: scrollCtrl,
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                        itemCount: pending.length,
                        separatorBuilder: (context, index) => Gap(12.h),
                        itemBuilder: (_, i) {
                          final notif = pending[i];
                          return FullNotificationCard(
                            notification: notif,
                            cardBg: cardBg,
                            onApprove: () => _approve(notif),
                            onReject: () => _reject(notif),
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
