import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutAppBar extends StatelessWidget {
  const AboutAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 380.h,
      pinned: true,
      backgroundColor: AppColor.appBarColor(context),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.whiteColor(context),
          size: 22.sp,
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: 16.h),
        title: Text(
          AppLocaleKey.aboutCompany.tr(),
          style: TextStyle(
            color: AppColor.whiteColor(context),
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/profile.jpeg', fit: BoxFit.cover, height: 180.h),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
