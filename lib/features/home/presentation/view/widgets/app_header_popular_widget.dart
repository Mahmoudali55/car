import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.h,
      floating: true,
      pinned: true,
      backgroundColor: AppColor.scaffoldColor(context),
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.blackTextColor(context),
          size: 20.sp,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          title,
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        background: HeaderBackground(),
      ),
    );
  }
}

class HeaderBackground extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColor.primaryColor(context).withOpacity(0.1),
            AppColor.scaffoldColor(context),
          ],
        ),
      ),
    );
  }
}

class BrandHeader extends StatelessWidget {
  const BrandHeader({required this.brandName, required this.count});

  final String brandName;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 30.h, 20.w, 15.h),
      child: Row(
        children: [
          Container(
            width: 4.w,
            height: 24.h,
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Gap(12.w),
          Text(
            brandName.toUpperCase(),
            style: AppTextStyle.titleMedium(
              context,
            ).copyWith(fontWeight: FontWeight.w900, letterSpacing: 2),
          ),
          const Spacer(),
          Text(
            '$count ${AppLocaleKey.cars.tr()}',
            style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
          ),
        ],
      ),
    );
  }
}
