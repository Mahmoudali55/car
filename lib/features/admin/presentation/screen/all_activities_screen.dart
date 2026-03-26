import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AllActivitiesScreen extends StatelessWidget {
  const AllActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColor.blackTextColor(context),
          ),
        ),
        title: Text(
          AppLocaleKey.fullActivityLog.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 20,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => Gap(12.h),
        itemBuilder: (context, index) => FadeInUp(
          delay: Duration(milliseconds: index * 30),
          child: _buildActivityCard(context, index),
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, int index) {
    final activities = [
      {
        'title': AppLocaleKey.newCarAddedActivity.tr(),
        'desc': AppLocaleKey.addedByAdmin.tr(),
        'time': '10 min', // Or use a generic time key
        'icon': Icons.add_business_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': AppLocaleKey.newInspectionRequest.tr(),
        'desc': AppLocaleKey.fromUser.tr(),
        'time': '25 min',
        'icon': Icons.car_repair_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': AppLocaleKey.newUserJoined.tr(),
        'desc': AppLocaleKey.userEmailLabel.tr(),
        'time': '1 hour',
        'icon': Icons.person_add_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': AppLocaleKey.successfulPaymentTitle.tr(),
        'desc': AppLocaleKey.amountLabel.tr(),
        'time': '3 hours',
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF2DD4BF),
      },
    ];

    final act = activities[index % activities.length];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withOpacity(0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: (act['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              act['icon'] as IconData,
              color: act['color'] as Color,
              size: 22.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  act['title'] as String,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(2.h),
                Text(
                  act['desc'] as String,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context).withOpacity(0.4),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            act['time'] as String,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withOpacity(0.3),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
