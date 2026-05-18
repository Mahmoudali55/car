import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ManageUsersScreen extends StatefulWidget {
  const ManageUsersScreen({super.key});

  @override
  State<ManageUsersScreen> createState() => _ManageUsersScreenState();
}

class _ManageUsersScreenState extends State<ManageUsersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.adminUserManagement.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildQuickStats(context),
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildUserList(context, 'Customer'),
                _buildUserList(context, 'Agent'),
                _buildUserList(context, 'Admin'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Row(
        children: [
          _buildStatItem(context, AppLocaleKey.totalUsers.tr(), '1,248', Colors.blueAccent),
          Gap(12.w),
          _buildStatItem(context, AppLocaleKey.activeAgents.tr(), '34', Colors.purpleAccent),
        ],
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withValues(alpha: 0.1)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: AppColor.whiteColor(context),
        unselectedLabelColor: AppColor.blackTextColor(context).withValues(alpha: 0.4),
        indicator: BoxDecoration(
          color: AppColor.primaryColor(context),
          borderRadius: BorderRadius.circular(16.r),
        ),
        tabs: [
          Tab(text: AppLocaleKey.customers.tr()),
          Tab(text: AppLocaleKey.agents.tr()),
          Tab(text: AppLocaleKey.admins.tr()),
        ],
      ),
    );
  }

  Widget _buildUserList(BuildContext context, String role) {
    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: 8,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Gap(16.h),
      itemBuilder: (context, index) => FadeInUp(
        delay: Duration(milliseconds: index * 40),
        child: _buildUserCard(context, index, role),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, int index, String role) {
    final roleColor = role == 'Admin'
        ? Colors.redAccent
        : (role == 'Agent' ? Colors.purpleAccent : Colors.blueAccent);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20.r,
                    backgroundColor: roleColor.withValues(alpha: 0.1),
                    child: Icon(Icons.person_rounded, size: 20.sp, color: roleColor),
                  ),
                  Gap(12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${AppLocaleKey.userName.tr()} $index',
                        style: TextStyle(
                          color: AppColor.blackTextColor(context),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'user$index@example.com',
                        style: TextStyle(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                          fontSize: 11.sp,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: roleColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  role == 'Admin'
                      ? AppLocaleKey.admins.tr()
                      : (role == 'Agent' ? AppLocaleKey.agents.tr() : AppLocaleKey.customers.tr()),
                  style: TextStyle(color: roleColor, fontSize: 10.sp, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(
                  Icons.edit_rounded,
                  AppLocaleKey.edit.tr(),
                  AppColor.blueColor(context),
                ),
              ),
              Gap(12.w),
              Expanded(
                child: _buildActionButton(
                  Icons.block_rounded,
                  AppLocaleKey.cancel.tr(),
                  AppColor.redColor(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16.sp),
          Gap(8.w),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 11.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
