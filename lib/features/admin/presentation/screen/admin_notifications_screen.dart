import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminNotificationsScreen extends StatelessWidget {
  const AdminNotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        title: Text(
          AppLocaleKey.notifications.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.sp),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 10,
        separatorBuilder: (context, index) => Gap(12.h),
        itemBuilder: (context, index) => FadeInUp(
          delay: Duration(milliseconds: index * 50),
          child: _buildNotificationItem(context, index),
        ),
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, int index) {
    final notifications = [
      {
        'title': AppLocaleKey.newUrgentBooking.tr(),
        'desc': AppLocaleKey.newBookingBody.tr(),
        'time': AppLocaleKey.twoMinutesAgo.tr(),
        'type': 'booking',
      },
      {
        'title': AppLocaleKey.lowStockAlert.tr(),
        'desc': AppLocaleKey.lowStockBody.tr(),
        'time': AppLocaleKey.oneHourAgo.tr(),
        'type': 'inventory',
      },
      {
        'title': AppLocaleKey.paymentFailedTitle.tr(),
        'desc': AppLocaleKey.paymentFailedBody.tr(),
        'time': AppLocaleKey.threeHoursAgo.tr(),
        'type': 'payment',
      },
    ];

    final notif = notifications[index % notifications.length];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTypeIcon(notif['type'] as String),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif['title'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(4.h),
                Text(
                  notif['desc'] as String,
                  style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 11.sp),
                ),
                Gap(8.h),
                Text(
                  notif['time'] as String,
                  style: TextStyle(
                    color: AppColor.primaryColor(context),
                    fontSize: 9.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'booking':
        icon = Icons.calendar_today_rounded;
        color = Colors.orangeAccent;
      case 'inventory':
        icon = Icons.inventory_2_outlined;
        color = Colors.redAccent;
      case 'payment':
        icon = Icons.payment_rounded;
        color = Colors.redAccent;
      default:
        icon = Icons.notifications_none_rounded;
        color = Colors.blueAccent;
    }

    return Container(
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 20.sp),
    );
  }
}
