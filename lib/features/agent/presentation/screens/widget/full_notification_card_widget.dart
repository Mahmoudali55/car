import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/presentation/screens/widget/agent_notification_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/small_action_btn_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FullNotificationCard extends StatelessWidget {
  final AgentNotification notification;
  final Color cardBg;
  final VoidCallback onApprove;
  final VoidCallback onReject;

  const FullNotificationCard({
    super.key,
    required this.notification,
    required this.cardBg,
    required this.onApprove,
    required this.onReject,
  });
  String _timeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1) return 'الآن';
    if (diff.inMinutes < 60) return 'منذ ${diff.inMinutes} دقيقة';
    if (diff.inHours < 24) return 'منذ ${diff.inHours} ساعة';
    return 'منذ ${diff.inDays} يوم';
  }

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
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(color: AppColor.greyColor(context), fontSize: 11.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.h),
            Text(
              notification.body,
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: AppColor.darkTextColor(context), height: 1.5, fontSize: 13.sp),
            ),
            Gap(16.h),
            Row(
              children: [
                Expanded(
                  child: SmallActionBtn(
                    label: AppLocaleKey.approve.tr(),
                    icon: Icons.check_circle_rounded,
                    color: green,
                    onTap: onApprove,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: SmallActionBtn(
                    label: AppLocaleKey.reject.tr(),
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
