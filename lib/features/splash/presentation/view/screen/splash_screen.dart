import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  void _navigateToNextScreen() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (mounted) {
        if (HiveMethods.isFirstTime()) {
          NavigatorMethods.pushReplacementNamed(context, RoutesName.onboardingScreen);
        } else if (HiveMethods.getToken() != null || HiveMethods.isGuest()) {
          if (HiveMethods.getRole() == 'admin') {
            NavigatorMethods.pushReplacementNamed(context, RoutesName.adminDashboard);
          } else {
            NavigatorMethods.pushReplacementNamed(context, RoutesName.mainLayout);
          }
        } else {
          NavigatorMethods.pushReplacementNamed(context, RoutesName.loginScreen);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColor.secondAppColor(context),
              AppColor.gradientSecondaryColor(context),
              AppColor.primaryColor(context).withOpacity(0.3),
            ],
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 1500),
                    child: Container(
                      width: 140.w,
                      height: 140.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.primaryColor(context).withOpacity(0.4),
                            blurRadius: 40,
                            spreadRadius: 5,
                          ),
                          BoxShadow(
                            color: AppColor.blackTextColor(context).withOpacity(0.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        image: const DecorationImage(
                          image: AssetImage('assets/images/profile.jpeg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Gap(30.h),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: Text(
                      AppLocaleKey.carApp.tr(),
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blackTextColor(context),
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  Gap(10.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1500),
                    child: Text(
                      AppLocaleKey.qualityReliability.tr(),
                      style: AppTextStyle.text14RGrey(context).copyWith(
                        color: AppColor.blackTextColor(context).withOpacity(0.8),
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Gap(20.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 1000),
                    duration: const Duration(milliseconds: 1500),
                    child: Column(
                      children: [
                        Text(
                          AppLocaleKey.authorizedDistributor.tr(),
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor(context),
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          AppLocaleKey.brandsLine1.tr(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColor.blackTextColor(context).withOpacity(0.9),
                          ),
                        ),
                        Text(
                          AppLocaleKey.brandsLine2.tr(),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColor.blackTextColor(context).withOpacity(0.9),
                          ),
                        ),
                        Gap(12.h),
                        Text(
                          AppLocaleKey.financingAvailable.tr(),
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blackTextColor(context).withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 50.h,
              left: 0,
              right: 0,
              child: FadeIn(
                delay: const Duration(seconds: 1),
                duration: const Duration(milliseconds: 1000),
                child: Center(
                  child: SizedBox(
                    width: 40.w,
                    height: 40.w,
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor(context),
                      strokeWidth: 3,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
