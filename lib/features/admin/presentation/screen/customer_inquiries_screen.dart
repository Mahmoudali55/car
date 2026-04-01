import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomerInquiriesScreen extends StatefulWidget {
  const CustomerInquiriesScreen({super.key});

  @override
  State<CustomerInquiriesScreen> createState() => _CustomerInquiriesScreenState();
}

class _CustomerInquiriesScreenState extends State<CustomerInquiriesScreen> with SingleTickerProviderStateMixin {
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
          AppLocaleKey.adminCustomerInquiries.tr(),
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
                _buildInquiryList(context, AppLocaleKey.adminInquiryStatusNew),
                _buildInquiryList(context, AppLocaleKey.adminInquiryStatusReview),
                _buildInquiryList(context, AppLocaleKey.adminInquiryStatusClosed),
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
          _buildStatItem(context, AppLocaleKey.adminConversionRate.tr(), '24%', Colors.greenAccent),
          Gap(12.w),
          _buildStatItem(context, AppLocaleKey.adminInquiryStatusNew.tr(), '14', Colors.blueAccent),
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
            Text(label, style: TextStyle(color: color, fontSize: 10.sp, fontWeight: FontWeight.bold)),
            Text(value, style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 18.sp, fontWeight: FontWeight.w900)),
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
        labelColor: Colors.white,
        unselectedLabelColor: AppColor.blackTextColor(context).withValues(alpha: 0.4),
        indicator: BoxDecoration(
          color: AppColor.primaryColor(context),
          borderRadius: BorderRadius.circular(16.r),
        ),
        tabs: [
          Tab(text: AppLocaleKey.adminInquiryStatusNew.tr()),
          Tab(text: AppLocaleKey.adminInquiryStatusReview.tr()),
          Tab(text: AppLocaleKey.adminInquiryStatusClosed.tr()),
        ],
      ),
    );
  }

  Widget _buildInquiryList(BuildContext context, String statusKey) {
    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: 6,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Gap(16.h),
      itemBuilder: (context, index) => FadeInUp(
        delay: Duration(milliseconds: index * 40),
        child: _buildInquiryCard(context, index, statusKey),
      ),
    );
  }

  Widget _buildInquiryCard(BuildContext context, int index, String statusKey) {
    final statusColor = statusKey == AppLocaleKey.adminInquiryStatusNew
        ? Colors.blueAccent
        : (statusKey == AppLocaleKey.adminInquiryStatusReview ? Colors.orangeAccent : Colors.grey);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(28.r),
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
                  CircleAvatar(radius: 18.r, backgroundColor: AppColor.blackTextColor(context).withValues(alpha: 0.05), child: Icon(Icons.person_outline_rounded, size: 20.sp, color: AppColor.blackTextColor(context).withValues(alpha: 0.5))),
                  Gap(12.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('سالم العتيبي', style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 13.sp, fontWeight: FontWeight.bold)),
                      Text('منذ 3 ساعات', style: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.3), fontSize: 10.sp)),
                    ],
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10.r)),
                child: Text(statusKey.tr(), style: TextStyle(color: statusColor, fontSize: 10.sp, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            'أرغب في الاستفسار عن توفر مرسيدس G63 موديل 2024 باللون الأسود المطفي.',
            style: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.7), fontSize: 12.sp),
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton(Icons.chat_bubble_outline_rounded, 'رد سريع', Colors.blueAccent),
              ),
              Gap(12.w),
              Expanded(
                child: _buildActionButton(Icons.phone_in_talk_rounded, 'اتصال', Colors.greenAccent),
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
      decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(14.r)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16.sp),
          Gap(8.w),
          Text(label, style: TextStyle(color: color, fontSize: 11.sp, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
