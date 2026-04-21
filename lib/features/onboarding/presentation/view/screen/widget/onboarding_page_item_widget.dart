import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/onboarding/data/model/on_boarding_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                color: AppColor.primaryColor(context).withOpacity(0.15),
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
                      color: AppColor.blackTextColor(context).withOpacity(0.8),
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
