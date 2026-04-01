import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class DiscountCouponsScreen extends StatelessWidget {
  const DiscountCouponsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.discountCoupons.tr())),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: Colors.orangeAccent,
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          AppLocaleKey.createCoupon.tr(),
          style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPromoBanner(context),
            Gap(32.h),
            _buildCouponSection(context, AppLocaleKey.activeCoupons.tr(), [
              _buildCouponCard(context, "ELITE2024", "25%", "Expires in 12 days", true),
              _buildCouponCard(context, "GUEST10", "10%", "Expires in 5 days", true),
            ]),
            Gap(32.h),
            _buildCouponSection(context, AppLocaleKey.expiredCoupons.tr(), [
              _buildCouponCard(context, "WINTER23", "15%", "Expired on Dec 31", false),
              _buildCouponCard(context, "NEWYEAR", "20%", "Expired on Jan 05", false),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildPromoBanner(BuildContext context) {
    return FadeInDown(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrangeAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(Icons.stars_rounded, color: Colors.white, size: 40.sp),
            Gap(16.h),
            Text(
              AppLocaleKey.promotionalHub.tr(),
              style: TextStyle(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            Gap(8.h),
            Text(
              "Drive sales by managing your administrative discount codes and seasonal offers.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white.withValues(alpha: 0.8), fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCouponSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(16.h),
        ...items,
      ],
    );
  }

  Widget _buildCouponCard(BuildContext context, String code, String discount, String expiry, bool isActive) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: baseColor.withValues(alpha: 0.05)),
          image: DecorationImage(
            image: const AssetImage('assets/images/coupon_pattern.png'), // Placeholder or subtle pattern
            opacity: 0.02,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: isActive ? Colors.orangeAccent.withValues(alpha: 0.1) : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  discount,
                  style: TextStyle(
                    color: isActive ? Colors.orangeAccent : Colors.grey,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Gap(20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    code,
                    style: TextStyle(
                      color: baseColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  Gap(4.h),
                  Text(
                    expiry,
                    style: TextStyle(
                      color: baseColor.withValues(alpha: 0.4),
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined, color: baseColor.withValues(alpha: 0.3), size: 18.sp),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.delete_outline_rounded, color: Colors.redAccent.withValues(alpha: 0.5), size: 18.sp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
