import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Premium Header Section
        FadeInDown(
          duration: const Duration(milliseconds: 600),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocaleKey.ourServices.tr(),
                        style: AppTextStyle.titleLarge(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 26.sp,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        AppLocaleKey.showroomSubtitle.tr(),
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(color: Colors.white70, fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, RoutesName.settingsScreen),
                      icon: Icon(Icons.settings_outlined, color: Colors.white70, size: 24.sp),
                    ),
                    Gap(8.w),
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor(context).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.2)),
                      ),
                      child: Icon(
                        Icons.stars_rounded,
                        color: AppColor.primaryColor(context),
                        size: 26.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: ListView(
            padding: EdgeInsets.only(top: 10.h, bottom: 120.h),
            physics: const BouncingScrollPhysics(),
            children: [
              // Hero Action Section: Sell or Trade
              FadeInUp(
                duration: const Duration(milliseconds: 800),
                child: _buildHeroActionSection(context),
              ),
              Gap(24.h),

              // Showroom Services Grid title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: FadeInLeft(
                  child: Text(
                    AppLocaleKey.services.tr(),
                    style: AppTextStyle.titleMedium(
                      context,
                    ).copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                ),
              ),
              Gap(16.h),

              // Custom Animated Grid
              _buildServicesGrid(context),
              Gap(32.h),

              // Specialist Solutions Section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: FadeInLeft(
                  child: Text(
                    AppLocaleKey.expertAppraisal.tr(),
                    style: AppTextStyle.titleMedium(
                      context,
                    ).copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                ),
              ),
              Gap(16.h),
              FadeInUp(child: _buildValuationCard(context)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeroActionSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColor.primaryColor(context), AppColor.primaryColor(context).withBlue(150)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor(context).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.directions_car_filled_rounded,
              size: 140.sp,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  AppLocaleKey.specialOffer.tr(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gap(12.h),
              Text(
                AppLocaleKey.sellYourCar.tr(),
                style: AppTextStyle.titleLarge(
                  context,
                ).copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 22.sp),
              ),
              Gap(8.h),
              Text(
                'نحن نشتري سيارتك بأفضل قيمة سوقية فوراً',
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: Colors.white.withOpacity(0.9)),
              ),
              Gap(20.h),
              ElevatedButton(
                onPressed: () {
                  if (HiveMethods.getToken() == null) {
                    CommonMethods.showLoginRequiredDialog(context);
                  } else {
                    // TODO: Implement Booking
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColor.primaryColor(context),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                  elevation: 0,
                ),
                child: Text(
                  AppLocaleKey.bookService.tr(),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {
        'icon': Icons.swap_horizontal_circle_rounded,
        'label': AppLocaleKey.tradeIn.tr(),
        'color': const Color(0xFF6366F1),
      },
      {
        'icon': Icons.public_rounded,
        'label': AppLocaleKey.importOnDemand.tr(),
        'color': const Color(0xFF10B981),
      },
      {
        'icon': Icons.account_balance_wallet_rounded,
        'label': AppLocaleKey.financingSolutions.tr(),
        'color': const Color(0xFFF59E0B),
      },
      {
        'icon': Icons.auto_awesome_rounded,
        'label': AppLocaleKey.showroomShine.tr(),
        'color': const Color(0xFFEC4899),
      },
      {
        'icon': Icons.local_shipping_rounded,
        'label': AppLocaleKey.vipShipping.tr(),
        'color': const Color(0xFF8B5CF6),
      },
      {
        'icon': Icons.person_search_rounded,
        'label': AppLocaleKey.bespokeSelection.tr(),
        'color': const Color(0xFF0EA5E9),
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16.h,
          crossAxisSpacing: 16.w,
          childAspectRatio: 1.05,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return FadeInUp(
            delay: Duration(milliseconds: 100 * index),
            child: _buildServiceCard(
              context,
              services[index]['icon'] as IconData,
              services[index]['label'] as String,
              services[index]['color'] as Color,
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard(BuildContext context, IconData icon, String label, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (HiveMethods.getToken() == null) {
              CommonMethods.showLoginRequiredDialog(context);
            } else {
              // TODO: Implement Service Details
            }
          },
          borderRadius: BorderRadius.circular(28.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: accentColor, size: 28.sp),
                ),
                Gap(14.h),
                Text(
                  label,
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.sp),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildValuationCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.amber.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18.r),
            ),
            child: Icon(Icons.analytics_rounded, color: Colors.amber, size: 30.sp),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocaleKey.carValuation.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                Gap(4.h),
                Text(
                  AppLocaleKey.findSpecificCar.tr(),
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: Colors.white54, fontSize: 11.sp),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios_rounded, color: Colors.white24, size: 16.sp),
        ],
      ),
    );
  }
}
