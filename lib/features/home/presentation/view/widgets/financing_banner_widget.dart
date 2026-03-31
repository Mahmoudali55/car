import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingBannerWidget extends StatelessWidget {
  const FinancingBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      child: GestureDetector(
        onTap: () {
          // Navigate to Financing Screen
          Navigator.pushNamed(context, 'financingScreen');
        },
        child: Container(
          width: double.infinity,
          height: 160.h,
          margin: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            gradient: LinearGradient(
              colors: [
                AppColor.primaryColor(context),
                const Color(0xff0047BB),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Abstract Design Elements
              Positioned(
                right: -30.w,
                top: -20.h,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(
                    Icons.account_balance_rounded,
                    size: 180.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            AppLocaleKey.specialOffer.tr(),
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gap(8.h),
                    Text(
                      AppLocaleKey.calculateFinancing.tr(),
                      style: AppTextStyle.titleMedium(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 20.sp,
                      ),
                    ),
                    Gap(4.h),
                    SizedBox(
                      width: 200.w,
                      child: Text(
                        AppLocaleKey.financingSolutionsDesc.tr(),
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: Colors.white.withValues(alpha: 0.8),
                          fontSize: 12.sp,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        AppLocaleKey.getStarted.tr(),
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
