import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      title: AppLocaleKey.exploreLuxuryCars.tr(),
      description: AppLocaleKey.exploreLuxuryCars.tr(),
      image: 'assets/images/onboarding_car_selection.png',
      isImage: true,
    ),
    OnboardingModel(
      title: AppLocaleKey.expertMaintenance.tr(),
      description: AppLocaleKey.expertMaintenance.tr(),
      image: 'assets/images/onboarding_car_service.png',
      isImage: true,
    ),
    OnboardingModel(
      title: AppLocaleKey.fastSecureDelivery.tr(),
      description: AppLocaleKey.experienceSeamlessDelivery.tr(),
      image: Icons.speed_rounded,
      isImage: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColor.secondAppColor(context),
              AppColor.gradientSecondaryColor(context),
              AppColor.primaryColor(context).withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingPageItem(model: _pages[index]);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicators
                  Row(
                    children: List.generate(
                      _pages.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(right: 8.w),
                        height: 8.h,
                        width: _currentPage == index ? 24.w : 8.w,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? AppColor.primaryColor(context)
                              : AppColor.blackTextColor(context).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: _currentPage == index
                              ? [
                                  BoxShadow(
                                    color: AppColor.primaryColor(
                                      context,
                                    ).withValues(alpha: 0.4),
                                    blurRadius: 10,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                      ),
                    ),
                  ),
                  // Next / Get Started Button
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.primaryColor(
                            context,
                          ).withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_currentPage == _pages.length - 1) {
                          HiveMethods.updateFirstTime();
                          NavigatorMethods.pushReplacementNamed(
                            context,
                            RoutesName.loginScreen,
                          );
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeInOut,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor(context),
                        foregroundColor: AppColor.whiteColor(context),
                        padding: EdgeInsets.symmetric(
                          horizontal: 32.w,
                          vertical: 16.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentPage == _pages.length - 1
                            ? AppLocaleKey.getStarted.tr()
                            : AppLocaleKey.next.tr(),
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingModel {
  final String title;
  final String description;
  final dynamic image;
  final bool isImage;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
    required this.isImage,
  });
}

class OnboardingPageItem extends StatelessWidget {
  final OnboardingModel model;

  const OnboardingPageItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: Container(
              height: 300.h,
              width: 300.h,
              margin: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: model.isImage
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(150),
                        child: Image.asset(
                          model.image,
                          fit: BoxFit.cover,
                          height: 260.h,
                          width: 260.h,
                        ),
                      )
                    : Icon(
                        model.image as IconData,
                        size: 150.h,
                        color: AppColor.primaryColor(context),
                      ),
              ),
            ),
          ),
          SizedBox(height: 40.h),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w),
              child: Column(
                children: [
                  Text(
                    model.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    model.description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.8),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
