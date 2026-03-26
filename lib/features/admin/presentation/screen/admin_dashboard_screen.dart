import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          _buildBackgroundAura(),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(child: _buildHeader(context)),
                  Gap(24.h),
                  FadeInUp(child: _buildPerformanceChart(context)),
                  Gap(32.h),
                  FadeInLeft(child: _buildUrgentApprovals(context)),
                  Gap(32.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildActivityFeed(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundAura() {
    return Positioned(
      top: -150.h,
      right: -150.w,
      child: Container(
        width: 400.w,
        height: 400.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF3B82F6).withOpacity(0.05),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withOpacity(0.05),
              blurRadius: 100,
              spreadRadius: 50,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocaleKey.centralDashboard.tr(),
              style: AppTextStyle.titleMedium(
                context,
              ).copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22.sp),
            ),
            Gap(4.h),
            Text(
              AppLocaleKey.performanceSummary.tr(),
              style: TextStyle(
                color: Colors.white.withOpacity(0.4),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            _buildHeaderAction(
              Icons.notifications_none_rounded,
              AppColor.primaryColor(context),
              onTap: () => Navigator.pushNamed(context, RoutesName.adminNotifications),
            ),
            Gap(12.w),
            _buildHeaderAction(
              Icons.logout_rounded,
              Colors.redAccent,
              onTap: () {
                HiveMethods.deleteToken();
                HiveMethods.updateRole('user');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.loginScreen,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderAction(IconData icon, Color color, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: Icon(icon, color: color, size: 22.sp),
      ),
    );
  }

  Widget _buildPerformanceChart(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white.withOpacity(0.05), Colors.white.withOpacity(0.01)],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocaleKey.weeklyPerformanceIndex.tr(),
                style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '+14.2%',
                  style: TextStyle(
                    color: Colors.greenAccent,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Gap(20.h),
          // Simulated Chart
          SizedBox(
            height: 120.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final height = [40, 70, 50, 90, 60, 100, 80][index];
                return Container(
                  width: 35.w,
                  height: height.h,
                  decoration: BoxDecoration(
                    color: index == 5
                        ? AppColor.primaryColor(context)
                        : Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                    gradient: index == 5
                        ? LinearGradient(
                            colors: [
                              AppColor.primaryColor(context),
                              AppColor.primaryColor(context).withOpacity(0.5),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : null,
                  ),
                );
              }),
            ),
          ),
          Gap(12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri']
                .map(
                  (e) => Text(
                    e,
                    style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10.sp),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildUrgentApprovals(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocaleKey.urgentApprovalRequests.tr(),
              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800),
            ),
            Text(
              '3 طلبات',
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Gap(16.h),
        SizedBox(
          height: 160.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (context, index) => Gap(16.w),
            itemBuilder: (context, index) => _buildApprovalCard(context, index),
          ),
        ),
      ],
    );
  }

  Widget _buildApprovalCard(BuildContext context, int index) {
    return Container(
      width: 240.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: Colors.white.withOpacity(0.1),
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.white.withOpacity(0.5),
                  size: 18.sp,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'أحمد محمد',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'حجز مرسيدس G63', // This looks like dummy data, but I'll keep it English for now or add a generic key if needed.
                      style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 10.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  AppLocaleKey.reject.tr(),
                  Colors.redAccent.withOpacity(0.1),
                  Colors.redAccent,
                ),
              ),
              Gap(8.w),
              Expanded(
                child: _buildActionButton(
                  AppLocaleKey.approve.tr(),
                  AppColor.primaryColor(context).withOpacity(0.1),
                  AppColor.primaryColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color bg, Color text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(14.r)),
      child: Text(
        label,
        style: TextStyle(color: text, fontSize: 12.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildActivityFeed(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.recentActivityLog.tr(),
          style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.w800),
        ),
        Gap(16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => Gap(12.h),
          itemBuilder: (context, index) => _buildActivityItem(index),
        ),
      ],
    );
  }

  Widget _buildActivityItem(int index) {
    final titles = ['إضافة سيارة جديدة', 'تعديل سعر رحلة', 'مستخدم جديد انضم', 'فشل في الدفع'];
    final icons = [
      Icons.add_circle_outline,
      Icons.edit_note_rounded,
      Icons.person_add_alt_1_rounded,
      Icons.error_outline_rounded,
    ];
    final colors = [Colors.blueAccent, Colors.orangeAccent, Colors.greenAccent, Colors.redAccent];

    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.04)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors[index].withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icons[index], color: colors[index], size: 20.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titles[index],
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'منذ 24 دقيقة',
                  style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 10.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
