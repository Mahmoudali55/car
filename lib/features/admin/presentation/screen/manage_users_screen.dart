import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ManageUsersScreen extends StatelessWidget {
  const ManageUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.manageUsers.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            top: 100.h,
            left: -150.w,
            child: Container(
              width: 400.w,
              height: 400.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.02),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.02),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              children: [
                FadeInDown(child: _buildSearchBar(context)),
                Gap(24.h),
                Expanded(
                  child: ListView.separated(
                    itemCount: 12,
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => Gap(16.h),
                    itemBuilder: (context, index) => FadeInLeft(
                      delay: Duration(milliseconds: index * 50),
                      child: _buildUserCard(context, index),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withOpacity(0.05),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.1)),
          ),
          child: TextField(
            style: TextStyle(color: AppColor.blackTextColor(context)),
            decoration: InputDecoration(
              icon: Icon(
                Icons.search_rounded,
                color: AppColor.blackTextColor(context).withOpacity(0.5),
                size: 22.sp,
              ),
              hintText: AppLocaleKey.searchUserHint.tr(),
              hintStyle: TextStyle(
                color: AppColor.blackTextColor(context).withOpacity(0.3),
                fontSize: 13.sp,
              ),
              border: InputBorder.none,
              suffixIcon: Icon(
                Icons.tune_rounded,
                color: AppColor.primaryColor(context),
                size: 20.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserCard(BuildContext context, int index) {
    bool isActive = index % 3 != 0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(24.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withOpacity(0.03),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
          ),
          child: Row(
            children: [
              _buildUserAvatar(isActive, context),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'خالد محمد عبد الرحمن',
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'khaled@example.com',
                      style: TextStyle(
                        color: AppColor.blackTextColor(context).withOpacity(0.4),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              _buildStatusToggle(isActive),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserAvatar(bool isActive, BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 50.w,
          height: 50.w,
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withOpacity(0.1),
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColor.blackTextColor(context).withOpacity(0.2),
                AppColor.blackTextColor(context).withOpacity(0.01),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Icon(
            Icons.person_rounded,
            color: AppColor.blackTextColor(context).withOpacity(0.5),
            size: 24.sp,
          ),
        ),
        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: isActive ? Colors.greenAccent : Colors.redAccent,
              shape: BoxShape.circle,
              border: Border.all(color: AppColor.scaffoldColor(context), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatusToggle(bool isActive) {
    return Column(
      children: [
        Switch.adaptive(
          value: isActive,
          onChanged: (v) {},
          activeColor: Colors.greenAccent,
          activeTrackColor: Colors.greenAccent.withOpacity(0.2),
        ),
        Text(
          isActive ? AppLocaleKey.active.tr() : AppLocaleKey.banned.tr(),
          style: TextStyle(
            color: isActive ? Colors.greenAccent : Colors.redAccent,
            fontSize: 9.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
