import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomHeaderAgentInventoryWidget extends StatelessWidget {
  const CustomHeaderAgentInventoryWidget({super.key, required TabController tabController})
    : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: AppColor.appBarColor(context),
      expandedHeight: 80.h,
      elevation: 0,
      flexibleSpace: FlexibleSpaceBar(
        background: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
            child: Text(
              textAlign: TextAlign.center,
              AppLocaleKey.agentInventory.tr(),
              style: AppTextStyle.titleLarge(context).copyWith(
                color: AppColor.blackTextColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 18.sp,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ),
      ),
      bottom: TabBar(
        controller: _tabController,
        indicatorColor: AppColor.blueColor(context),
        indicatorWeight: 3.5.h,
        indicatorSize: TabBarIndicatorSize.label,
        labelColor: AppColor.blackTextColor(context),
        unselectedLabelColor: AppColor.hintColor(context),
        labelStyle: AppTextStyle.bodySmall(context).copyWith(fontWeight: FontWeight.w900),
        unselectedLabelStyle: AppTextStyle.bodySmall(context).copyWith(fontWeight: FontWeight.w600),
        indicatorPadding: EdgeInsets.symmetric(horizontal: 4.w),
        tabs: [
          Tab(text: AppLocaleKey.agentAvailable.tr()),
          Tab(text: AppLocaleKey.agentReserved.tr()),
          Tab(text: AppLocaleKey.agentSold.tr()),
        ],
      ),
    );
  }
}
