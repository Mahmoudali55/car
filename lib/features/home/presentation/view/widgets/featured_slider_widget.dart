import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturedSliderWidget extends StatelessWidget {
  const FeaturedSliderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryColor(context),
                        AppColor.primaryColor(context).withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor(context).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30.w,
                        bottom: -30.h,
                        child: Opacity(
                          opacity: 0.15,
                          child: Icon(Icons.speed_rounded, size: 200.w, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                AppLocaleKey.specialOffer.tr().toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              "Porsche 911 GT3 RS",
                              style: AppTextStyle.titleLarge(context, color: Colors.white),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.timer_outlined, color: Colors.white70, size: 14.w),
                                SizedBox(width: 6.w),
                                Text(
                                  AppLocaleKey.limitedTime.tr(),
                                  style: AppTextStyle.bodySmall(context, color: Colors.white70),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "AED 980,000",
                                      style: AppTextStyle.titleMedium(context, color: Colors.white),
                                    ),
                                    Text(
                                      "Monthly from AED 12,500",
                                      style: TextStyle(color: Colors.white60, fontSize: 9.sp),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColor.primaryColor(context),
                                    size: 16.w,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: index == 0 ? 20.w : 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: index == 0 ? AppColor.primaryColor(context) : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
