import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

// ─── Model ───────────────────────────────────────────────────────────────────

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

// ─── Demo data (استبدلها بالبيانات الحقيقية من API) ─────────────────────────

List<AgentNotification> agentNotifications = [
  AgentNotification(
    id: '1',
    title: 'طلب حجز جديد',
    body: 'العميل أحمد محمد يطلب حجز سيارة تويوتا كامري 2024 — يرجى المراجعة والرد.',
    createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  AgentNotification(
    id: '2',
    title: 'عرض سعر معلّق',
    body: 'تم إرسال عرض سعر للعميل سارة خالد وينتظر موافقتك لإتمام الإجراءات.',
    createdAt: DateTime.now().subtract(const Duration(hours: 1)),
  ),
  AgentNotification(
    id: '3',
    title: 'موعد قادم',
    body: 'لديك موعد مع العميل محمد علي غداً الساعة 10:00 صباحاً — تأكيد الموعد مطلوب.',
    createdAt: DateTime.now().subtract(const Duration(hours: 3)),
  ),
  AgentNotification(
    id: '4',
    title: 'طلب تعديل عقد',
    body: 'العميل فيصل العمري يطلب تعديل بنود العقد الخاص بسيارة نيسان باترول 2024.',
    createdAt: DateTime.now().subtract(const Duration(hours: 5)),
  ),
  AgentNotification(
    id: '5',
    title: 'موافقة مالية مطلوبة',
    body: 'طلب تمويل العميل نورة السالم بانتظار مراجعتك وإرساله للجهة المختصة.',
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
];

// ─── Helper ──────────────────────────────────────────────────────────────────

String _timeAgo(DateTime dt) {
  final diff = DateTime.now().difference(dt);
  if (diff.inMinutes < 1) return 'الآن';
  if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
  if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
  return 'منذ ${diff.inDays} يوم';
}

// ─── Notification Slider Section ─────────────────────────────────────────────

class AgentNotificationSlider extends StatefulWidget {
  const AgentNotificationSlider({super.key});

  @override
  State<AgentNotificationSlider> createState() => _AgentNotificationSliderState();
}

class _AgentNotificationSliderState extends State<AgentNotificationSlider> {
  List<AgentNotification> get _pending =>
      agentNotifications.where((n) => !n.isRead).toList();

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
        content: Text(msg,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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
      builder: (_) => _AgentNotificationsSheet(onChanged: () => setState(() {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pending = _pending;
    final blue = AppColor.blueColor(context);
    final orange = AppColor.orangeColor(context);

    if (pending.isEmpty) return const SizedBox.shrink();

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
                    'طلبات الإشعارات',
                    style: AppTextStyle.bodyLarge(context).copyWith(
                      color: AppColor.blackTextColor(context),
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.4,
                    ),
                  ),
                  Gap(10.w),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: orange.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: orange.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      '${pending.length}',
                      style: AppTextStyle.bodySmall(context)
                          .copyWith(color: orange, fontWeight: FontWeight.w900),
                    ),
                  ),
                ],
              ),
            ),
            // مشاهدة الكل
            GestureDetector(
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
                      'مشاهدة الكل',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: blue,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.sp,
                      ),
                    ),
                    Gap(4.w),
                    Icon(Icons.arrow_forward_ios_rounded, color: blue, size: 11.sp),
                  ],
                ),
              ),
            ),
          ],
        ),

        Gap(12.h),

        // ── Horizontal Slider ──
        SizedBox(
          height: 190.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: preview.length,
            separatorBuilder: (context, index) => Gap(12.w),
            itemBuilder: (_, i) {
              final notif = preview[i];
              return _SliderNotifCard(
                notification: notif,
                onApprove: () => _approve(notif),
                onReject: () => _reject(notif),
              );
            },
          ),
        ),
      ],
    );
  }
}

// ─── Slider Card (compact horizontal card) ───────────────────────────────────

class _SliderNotifCard extends StatelessWidget {
  final AgentNotification notification;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _SliderNotifCard({
    required this.notification,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final cardBg = AppColor.cardColor(context);
    final blue = AppColor.blueColor(context);
    final green = AppColor.greenColor(context);
    final red = AppColor.redColor(context);

    // card width = ~75% screen width so 3 cards are partially visible
    final cardWidth = (MediaQuery.of(context).size.width - 32.w) * 0.78;

    return Container(
      width: cardWidth,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.dividerColor(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Icon + title + time ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36.w,
                  height: 36.w,
                  decoration: BoxDecoration(
                    color: blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(11.r),
                  ),
                  child: Icon(Icons.notifications_active_rounded, color: blue, size: 18.sp),
                ),
                Gap(10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackTextColor(context),
                          fontSize: 13.sp,
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        _timeAgo(notification.createdAt),
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.greyColor(context),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Gap(10.h),

            // ── Body ──
            Expanded(
              child: Text(
                notification.body,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.darkTextColor(context),
                  height: 1.5,
                  fontSize: 12.sp,
                ),
              ),
            ),

            Gap(12.h),

            // ── Buttons ──
            Row(
              children: [
                Expanded(
                  child: _SmallActionBtn(
                    label: 'موافقة',
                    icon: Icons.check_rounded,
                    color: green,
                    onTap: onApprove,
                  ),
                ),
                Gap(8.w),
                Expanded(
                  child: _SmallActionBtn(
                    label: 'رفض',
                    icon: Icons.close_rounded,
                    color: red,
                    isOutlined: true,
                    onTap: onReject,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Small Action Button ──────────────────────────────────────────────────────

class _SmallActionBtn extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isOutlined;
  final VoidCallback onTap;

  const _SmallActionBtn({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    this.isOutlined = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: 38.h,
          decoration: BoxDecoration(
            color: isOutlined ? Colors.transparent : color,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 15.sp, color: isOutlined ? color : Colors.white),
              Gap(4.w),
              Text(
                label,
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: isOutlined ? color : Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Full Bottom Sheet ────────────────────────────────────────────────────────

class _AgentNotificationsSheet extends StatefulWidget {
  final VoidCallback onChanged;
  const _AgentNotificationsSheet({required this.onChanged});

  @override
  State<_AgentNotificationsSheet> createState() => _AgentNotificationsSheetState();
}

class _AgentNotificationsSheetState extends State<_AgentNotificationsSheet> {
  List<AgentNotification> get _notifications =>
      agentNotifications.where((n) => !n.isRead).toList();

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
        content: Text(msg,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
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
                            style: AppTextStyle.bodySmall(context)
                                .copyWith(color: AppColor.greyColor(context)),
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
                    ? _EmptyState()
                    : ListView.separated(
                        controller: scrollCtrl,
                        padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                        itemCount: pending.length,
                        separatorBuilder: (context, index) => Gap(12.h),
                        itemBuilder: (_, i) {
                          final notif = pending[i];
                          return _FullNotificationCard(
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

// ─── Full Notification Card (in bottom sheet) ─────────────────────────────────

class _FullNotificationCard extends StatelessWidget {
  final AgentNotification notification;
  final Color cardBg;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const _FullNotificationCard({
    required this.notification,
    required this.cardBg,
    required this.onApprove,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final blue = AppColor.blueColor(context);
    final green = AppColor.greenColor(context);
    final red = AppColor.redColor(context);

    return Container(
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.dividerColor(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 38.w,
                  height: 38.w,
                  decoration: BoxDecoration(
                    color: blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.notifications_active_rounded, color: blue, size: 19.sp),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.blackTextColor(context),
                        ),
                      ),
                      Gap(2.h),
                      Text(
                        _timeAgo(notification.createdAt),
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.greyColor(context),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.h),
            Text(
              notification.body,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: AppColor.darkTextColor(context),
                height: 1.5,
                fontSize: 13.sp,
              ),
            ),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: _SmallActionBtn(
                    label: 'موافقة',
                    icon: Icons.check_circle_rounded,
                    color: green,
                    onTap: onApprove,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: _SmallActionBtn(
                    label: 'رفض',
                    icon: Icons.cancel_rounded,
                    color: red,
                    isOutlined: true,
                    onTap: onReject,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off_rounded,
            size: 64.sp,
            color: AppColor.greyColor(context).withValues(alpha: 0.4),
          ),
          Gap(16.h),
          Text(
            'لا توجد إشعارات جديدة',
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.greyColor(context),
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(8.h),
          Text(
            'ستظهر هنا جميع الإشعارات التي تحتاج ردّك',
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.greyColor(context).withValues(alpha: 0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
