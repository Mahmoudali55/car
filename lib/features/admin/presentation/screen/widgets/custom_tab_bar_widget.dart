import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabBarWidget extends StatelessWidget {
  const CustomTabBarWidget({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(6.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: TabBar(
        controller: _tabController,
        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: AppTextStyle.bodySmall(context).copyWith(fontWeight: FontWeight.bold),
        unselectedLabelStyle: AppTextStyle.bodyMedium(context),
        labelColor: AppColor.whiteColor(context),
        unselectedLabelColor: AppColor.blackTextColor(context).withValues(alpha: 0.4),
        indicator: BoxDecoration(
          color: AppColor.primaryColor(context),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor(context).withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        tabs: [
          Tab(text: AppLocaleKey.employees.tr()),
          Tab(text: AppLocaleKey.suppliers.tr()),
          Tab(text: AppLocaleKey.customers.tr()),
        ],
      ),
    );
  }
}
