import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ContentManagementScreen extends StatefulWidget {
  const ContentManagementScreen({super.key});

  @override
  State<ContentManagementScreen> createState() => _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          AppLocaleKey.adminContentModeration.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [_buildReviewsList(context), _buildFeaturedAdsList(context)],
            ),
          ),
        ],
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
          Tab(text: AppLocaleKey.adminUserReviews.tr()),
          Tab(text: AppLocaleKey.adminFeaturedAds.tr()),
        ],
      ),
    );
  }

  Widget _buildReviewsList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: 8,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Gap(16.h),
      itemBuilder: (context, index) => FadeInUp(
        delay: Duration(milliseconds: index * 40),
        child: _buildReviewCard(context, index),
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, int index) {
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
                  CircleAvatar(
                    radius: 16.r,
                    backgroundColor: AppColor.blackTextColor(context).withValues(alpha: 0.05),
                    child: Icon(
                      Icons.person,
                      size: 18.sp,
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                    ),
                  ),
                  Gap(12.w),
                  Text(
                    AppLocaleKey.mohamedAlshammari.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(Icons.star_rounded, color: Colors.orangeAccent, size: 14.sp),
                ),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            AppLocaleKey.dummyReviewText.tr(),
            style: TextStyle(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
              fontSize: 12.sp,
            ),
          ),
          Gap(16.h),
          Row(
            children: [
              Expanded(child: _buildActionBtn(AppLocaleKey.adminHide.tr(), Colors.redAccent)),
              Gap(12.w),
              Expanded(child: _buildActionBtn(AppLocaleKey.adminApprove.tr(), Colors.greenAccent)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedAdsList(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: 4,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Gap(20.h),
      itemBuilder: (context, index) => FadeInUp(
        delay: Duration(milliseconds: index * 40),
        child: _buildAdCard(context, index),
      ),
    );
  }

  Widget _buildAdCard(BuildContext context, int index) {
    return Container(
      height: 120.h,
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            width: 120.w,
            decoration: BoxDecoration(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(24.r)),
            ),
            child: Icon(
              Icons.image_outlined,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.2),
              size: 30.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocaleKey.mercedesAdTitle.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppLocaleKey.expiryDateLabel.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                      fontSize: 10.sp,
                    ),
                  ),
                  Row(
                    children: [
                      Switch.adaptive(
                        value: true,
                        onChanged: (v) {},
                        activeColor: AppColor.primaryColor(context),
                      ),
                      Text(
                        'نشط',
                        style: TextStyle(
                          color: AppColor.primaryColor(context),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionBtn(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14.r),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11.sp, fontWeight: FontWeight.bold),
      ),
    );
  }
}
