import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/content_management_screen.dart';
import 'package:car/features/admin/presentation/screen/customer_inquiries_screen.dart';
import 'package:car/features/admin/presentation/widget/admin_stats_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
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
                  FadeInUp(child: _buildStatsGrid(context)),
                  Gap(32.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: _buildPerformanceChart(context),
                  ),
                  Gap(24.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 250),
                    child: _buildManagementHub(context),
                  ),
                  Gap(32.h),
                  FadeInLeft(child: _buildUrgentApprovals(context)),
                  Gap(32.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
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
          color: const Color(0xFF3B82F6).withValues(alpha: 0.05),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF3B82F6).withValues(alpha: 0.05),
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
              style: AppTextStyle.titleMedium(context).copyWith(
                color: AppColor.blackTextColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 22.sp,
              ),
            ),
            Gap(4.h),
            Text(
              AppLocaleKey.performanceSummary.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
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
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.1)),
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
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColor.blackTextColor(context).withValues(alpha: 0.04),
            AppColor.blackTextColor(context).withValues(alpha: 0.01),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.adminSalesPerformance.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocaleKey.weeklyPerformanceIndex.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withValues(alpha: 0.1),
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
          Gap(24.h),
          SizedBox(
            height: 140.h,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const days = ['Sat', 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri'];
                        if (value.toInt() >= 0 && value.toInt() < days.length) {
                          return Text(
                            days[value.toInt()],
                            style: TextStyle(
                              color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                              fontSize: 10.sp,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 6,
                minY: 0,
                maxY: 6,
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 3),
                      FlSpot(1, 1),
                      FlSpot(2, 4),
                      FlSpot(3, 2.3),
                      FlSpot(4, 5),
                      FlSpot(5, 3.5),
                      FlSpot(6, 5),
                    ],
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryColor(context),
                        AppColor.primaryColor(context).withValues(alpha: 0.5),
                      ],
                    ),
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColor.primaryColor(context).withValues(alpha: 0.2),
                          AppColor.primaryColor(context).withValues(alpha: 0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopBrandsChart(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.adminMostRequestedBrands.tr(),
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(24.h),
          SizedBox(
            height: 160.h,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      sectionsSpace: 4,
                      centerSpaceRadius: 35,
                      sections: [
                        PieChartSectionData(
                          color: AppColor.primaryColor(context),
                          value: 45,
                          title: '45%',
                          radius: 40,
                          titleStyle: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.blueAccent,
                          value: 25,
                          title: '25%',
                          radius: 35,
                          titleStyle: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.orangeAccent,
                          value: 20,
                          title: '20%',
                          radius: 30,
                          titleStyle: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        PieChartSectionData(
                          color: Colors.greenAccent,
                          value: 10,
                          title: '10%',
                          radius: 25,
                          titleStyle: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(20.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLegendItem(context, 'Mercedes', AppColor.primaryColor(context)),
                      Gap(8.h),
                      _buildLegendItem(context, 'BMW', Colors.blueAccent),
                      Gap(8.h),
                      _buildLegendItem(context, 'Toyota', Colors.orangeAccent),
                      Gap(8.h),
                      _buildLegendItem(context, 'Tesla', Colors.greenAccent),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8.w,
          height: 8.h,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        Gap(8.w),
        Text(
          label,
          style: TextStyle(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.adminTotalCars.tr(),
                value: '124',
                icon: Icons.directions_car_filled_rounded,
                color: AppColor.primaryColor(context),
              ),
            ),
            Gap(16.w),
            Expanded(
              child: AdminStatsCard(
                title: AppLocaleKey.adminSoldCars.tr(),
                value: '86',
                icon: Icons.shopping_bag_rounded,
                color: Colors.greenAccent,
              ),
            ),
          ],
        ),
        Gap(16.h),
        AdminStatsCard(
          title: AppLocaleKey.adminPendingApprovals.tr(),
          value: '12',
          icon: Icons.pending_actions_rounded,
          color: Colors.orangeAccent,
        ),
      ],
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
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
            Text(
              AppLocaleKey.adminThreeRequests.tr(),
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
        color: AppColor.blackTextColor(context).withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18.r,
                backgroundColor: AppColor.blackTextColor(context).withValues(alpha: 0.1),
                child: Icon(
                  Icons.person_rounded,
                  color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                  size: 18.sp,
                ),
              ),
              Gap(12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocaleKey.customerName.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocaleKey.mercedesGClassBooking.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                        fontSize: 10.sp,
                      ),
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
                  Colors.redAccent.withValues(alpha: 0.1),
                  Colors.redAccent,
                ),
              ),
              Gap(8.w),
              Expanded(
                child: _buildActionButton(
                  AppLocaleKey.approve.tr(),
                  AppColor.primaryColor(context).withValues(alpha: 0.1),
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
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(16.h),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 4,
          separatorBuilder: (context, index) => Gap(12.h),
          itemBuilder: (context, index) => _buildActivityItem(index, context),
        ),
      ],
    );
  }

  Widget _buildActivityItem(int index, BuildContext context) {
    final titles = [
      AppLocaleKey.adminNewCarAddedActivity.tr(),
      AppLocaleKey.adminEditTripPrice.tr(),
      AppLocaleKey.adminNewUserJoinedActivity.tr(),
      AppLocaleKey.adminPaymentFailedBody.tr()
    ];
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
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors[index].withValues(alpha: 0.1),
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
                    color: AppColor.blackTextColor(context),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  AppLocaleKey.adminTwentyFourMinutesAgo.tr(),
                  style: TextStyle(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagementHub(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.managementActionCenter.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
        Gap(16.h),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.4,
          children: [
            _buildHubItem(
              context,
              AppLocaleKey.adminUserManagement.tr(),
              Icons.people_alt_rounded,
              Colors.blueAccent,
              () => Navigator.pushNamed(context, RoutesName.manageUsers),
            ),
            _buildHubItem(
              context,
              AppLocaleKey.adminCustomerInquiries.tr(),
              Icons.question_answer_rounded,
              Colors.orangeAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CustomerInquiriesScreen()),
              ),
            ),
            _buildHubItem(
              context,
              AppLocaleKey.adminContentModeration.tr(),
              Icons.fact_check_rounded,
              Colors.greenAccent,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContentManagementScreen()),
              ),
            ),
            _buildHubItem(
              context,
              AppLocaleKey.adminAdvancedReports.tr(),
              Icons.analytics_rounded,
              Colors.purpleAccent,
              () => Navigator.pushNamed(context, RoutesName.revenueReports),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHubItem(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20.sp),
            ),
            Text(
              label,
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
