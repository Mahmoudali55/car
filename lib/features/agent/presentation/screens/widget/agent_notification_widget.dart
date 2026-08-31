import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/agent_notifications_sheet_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/slider_notif_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentNotification {
  final String id;
  final String title;
  final String body;
  final DateTime createdAt;
  bool isRead;

  AgentNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    this.isRead = false,
  });
}

List<AgentNotification> agentNotifications = [];

class AgentNotificationSlider extends StatefulWidget {
  const AgentNotificationSlider({super.key});

  @override
  State<AgentNotificationSlider> createState() => _AgentNotificationSliderState();
}

class _AgentNotificationSliderState extends State<AgentNotificationSlider> {
  List<AgentNotification> get _pending => agentNotifications.where((n) => !n.isRead).toList();

  void _approve(AgentNotification notif) {
    setState(() {
      final idx = agentNotifications.indexWhere((n) => n.id == notif.id);
      if (idx != -1) agentNotifications[idx].isRead = true;
    });
    _showSnack('تمت الموافقة بنجاح ✓', AppColor.greenColor(context));
  }

  void _reject(AgentNotification notif) {
    setState(() => agentNotifications.removeWhere((n) => n.id == notif.id));
    _showSnack('تم رفض الإشعار', AppColor.redColor(context));
  }

  void _showSnack(String msg, Color color) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: AppColor.whiteColor(context), fontWeight: FontWeight.w600),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AgentNotificationsSheet(onChanged: () => setState(() {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending = _pending;
    final blue = AppColor.blueColor(context);
    final orange = AppColor.orangeColor(context);

    final preview = pending.take(3).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section Header ──
        Row(
          children: [
            Container(
              width: 5.w,
              height: 22.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [orange, orange.withValues(alpha: 0.4)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            Gap(12.w),
            Expanded(
              child: Row(
                children: [
                  Text(
                    AppLocaleKey.agentNewOrders.tr(),
                    style: AppTextStyle.bodyLarge(context).copyWith(
                      color: AppColor.blackTextColor(context),
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Gap(10.w),
                  pending.isNotEmpty
                      ? Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: orange.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: orange.withValues(alpha: 0.2)),
                          ),
                          child: Text(
                            '${pending.length}',
                            style: AppTextStyle.bodySmall(
                              context,
                            ).copyWith(color: orange, fontWeight: FontWeight.w900),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            preview.length < pending.length
                ? GestureDetector(
                    onTap: _openSheet,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: blue.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(color: blue.withValues(alpha: 0.15)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            AppLocaleKey.seeAll.tr(),
                            style: AppTextStyle.bodySmall(
                              context,
                            ).copyWith(color: blue, fontWeight: FontWeight.w700, fontSize: 12.sp),
                          ),
                          Gap(4.w),
                          Icon(Icons.arrow_forward_ios_rounded, color: blue, size: 11.sp),
                        ],
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
        Gap(12.h),
        pending.isNotEmpty
            ? SizedBox(
                height: 190.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.zero,
                  itemCount: preview.length,
                  separatorBuilder: (context, index) => Gap(12.w),
                  itemBuilder: (_, i) {
                    final notif = preview[i];
                    return SliderNotifCard(
                      notification: notif,
                      onApprove: () => _approve(notif),
                      onReject: () => _reject(notif),
                    );
                  },
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Icon(
                      Icons.notifications_none_rounded,
                      color: AppColor.hintColor(context),
                      size: 48.sp,
                    ),
                    Gap(16.h),
                    Text(
                      AppLocaleKey.agentNoNotifications.tr(),
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: AppColor.hintColor(context), fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
