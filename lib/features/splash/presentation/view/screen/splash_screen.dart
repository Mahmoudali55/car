import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  void _navigateToLogin() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      if (mounted) {
        NavigatorMethods.pushReplacementNamed(context, RoutesName.loginScreen);
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColor.primaryColor(context),
              AppColor.primaryColor(context).withOpacity(0.8),
              AppColor.secondAppColor(context),
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
                      padding: EdgeInsets.all(25.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        size: 80.w,
                        color: AppColor.primaryColor(context),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: Text(
                      'CAR APP',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    duration: const Duration(milliseconds: 1500),
                    child: Text(
                      'Quality & Reliability',
                      style: AppTextStyle.text14RGrey(
                        context,
                      ).copyWith(color: Colors.white.withOpacity(0.8), letterSpacing: 1.0),
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
                    child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
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
