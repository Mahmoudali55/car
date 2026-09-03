import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NotificationItemWidget extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onTap;

  const NotificationItemWidget({super.key, required this.notification, required this.onTap});

  String _relativeTime(BuildContext context, String value) {
    final aspNetDate = RegExp(r'^/Date\((\d+)(?:[+-]\d+)?\)/$').firstMatch(value);
    final createdAt = aspNetDate != null
        ? DateTime.fromMillisecondsSinceEpoch(int.parse(aspNetDate.group(1)!)).toLocal()
        : DateTime.tryParse(value.replaceFirst(' ', 'T'))?.toLocal();
    if (createdAt == null) return value;

    final difference = DateTime.now().difference(createdAt);
    final elapsed = difference.isNegative ? Duration.zero : difference;
    final languageCode = Localizations.localeOf(context).languageCode;
    if (languageCode == 'ar') {
      if (elapsed.inMinutes < 1) return 'منذ لحظات';
      if (elapsed.inHours < 1) {
        final minutes = elapsed.inMinutes;
        return minutes == 1 ? 'منذ دقيقة' : minutes == 2 ? 'منذ دقيقتين' : 'منذ $minutes دقائق';
      }
      if (elapsed.inDays < 1) {
        final hours = elapsed.inHours;
        return hours == 1 ? 'منذ ساعة' : hours == 2 ? 'منذ ساعتين' : 'منذ $hours ساعات';
      }
      final days = elapsed.inDays;
      if (days < 7) return days == 1 ? 'منذ يوم' : days == 2 ? 'منذ يومين' : 'منذ $days أيام';
      final weeks = days ~/ 7;
      return weeks == 1 ? 'منذ أسبوع' : weeks == 2 ? 'منذ أسبوعين' : 'منذ $weeks أسابيع';
    }

    if (elapsed.inMinutes < 1) return 'Just now';
    if (elapsed.inHours < 1) return '${elapsed.inMinutes}m ago';
    if (elapsed.inDays < 1) return '${elapsed.inHours}h ago';
    if (elapsed.inDays < 7) return '${elapsed.inDays}d ago';
    return '${elapsed.inDays ~/ 7}w ago';
  }

  @override
  Widget build(BuildContext context) {
    final bool isRead = notification['isRead'] as bool;
    final String type = notification['type'] as String;

    IconData icon;
    Color iconColor;

    switch (type) {
      case 'offer':
        icon = Icons.local_offer_rounded;
        iconColor = AppColor.iconColor(context);
        break;
      case 'order':
        icon = Icons.shopping_bag_rounded;
        iconColor = AppColor.greenColor(context);
        break;
      case 'system':
        icon = Icons.settings_rounded;
        iconColor = AppColor.primaryColor(context);
        break;
      case 'reservation':
        icon = Icons.access_time_rounded;
        iconColor = Colors.orange;
        break;
      default:
        icon = Icons.notifications_rounded;
        iconColor = Colors.grey;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isRead
              ? AppColor.secondAppColor(context).withValues(alpha: 0.5)
              : AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isRead
                ? Colors.transparent
                : AppColor.primaryColor(context).withValues(alpha: 0.3),
            width: 1,
          ),
          boxShadow: [
            if (!isRead)
              BoxShadow(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            Gap(16.w),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          notification['title'] as String,
                          style: AppTextStyle.bodyMedium(context).copyWith(
                            color: AppColor.blackTextColor(context),
                            fontWeight: isRead ? FontWeight.w500 : FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!isRead)
                        Container(
                          width: 8.w,
                          height: 8.w,
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor(context),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                  Gap(4.h),
                  Text(
                    notification['body'] as String,
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                      height: 1.4,
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    _relativeTime(context, notification['time'] as String),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
