import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
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
        // Header Section
        Padding(
          padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.ourServices.tr(),
                    style: AppTextStyle.titleLarge(
                      context,
                    ).copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 28.sp),
                  ),
                  Gap(4.h),
                  Text(
                    'نعتني بسيارتك بأعلى المعايير العالمية',
                    style: AppTextStyle.bodySmall(context).copyWith(color: Colors.white60),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.history_rounded,
                  color: AppColor.primaryColor(context),
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              // Quick Help Section (SOS Style)
              _buildQuickHelpSection(context),
              Gap(24.h),

              // Main Services Grid
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  AppLocaleKey.services.tr(),
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Gap(16.h),
              _buildServicesGrid(context),
              Gap(32.h),

              // Premium Maintenance Packages
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocaleKey.premiumPackages.tr(),
                      style: AppTextStyle.titleMedium(
                        context,
                      ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocaleKey.seeAll.tr(),
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.primaryColor(context)),
                    ),
                  ],
                ),
              ),
              Gap(16.h),
              _buildMaintenancePackages(context),
              Gap(120.h), // Spacing for bottom nav
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickHelpSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            AppLocaleKey.quickHelp.tr(),
            style: AppTextStyle.titleMedium(
              context,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Gap(16.h),
        SizedBox(
          height: 100.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            physics: const BouncingScrollPhysics(),
            children: [
              _buildQuickHelpItem(
                context,
                Icons.support_agent_rounded,
                AppLocaleKey.emergencyRecovery.tr(),
                Colors.redAccent,
              ),
              Gap(12.w),
              _buildQuickHelpItem(
                context,
                Icons.local_gas_station_rounded,
                AppLocaleKey.fuelDelivery.tr(),
                Colors.orangeAccent,
              ),
              Gap(12.w),
              _buildQuickHelpItem(
                context,
                Icons.battery_charging_full_rounded,
                AppLocaleKey.batteryJumpstart.tr(),
                Colors.blueAccent,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuickHelpItem(BuildContext context, IconData icon, String label, Color color) {
    return Container(
      width: 140.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28.sp),
          Gap(8.h),
          Text(
            label,
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildServicesGrid(BuildContext context) {
    final services = [
      {'icon': Icons.build_circle_rounded, 'label': AppLocaleKey.maintenanceRepair.tr()},
      {'icon': Icons.wash_rounded, 'label': AppLocaleKey.carWashing.tr()},
      {'icon': Icons.security_rounded, 'label': AppLocaleKey.tintingProtection.tr()},
      {'icon': Icons.tire_repair_rounded, 'label': AppLocaleKey.tireService.tr()},
      {'icon': Icons.find_in_page_rounded, 'label': AppLocaleKey.carInspection.tr()},
      {'icon': Icons.car_rental_rounded, 'label': 'خدمات التأجير'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.h,
        crossAxisSpacing: 16.w,
        childAspectRatio: 1.1,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        return _buildServiceCard(
          context,
          services[index]['icon'] as IconData,
          services[index]['label'] as String,
        );
      },
    );
  }

  Widget _buildServiceCard(BuildContext context, IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: AppColor.primaryColor(context), size: 30.sp),
          ),
          Gap(12.h),
          Text(
            label,
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildMaintenancePackages(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          _buildPackageCard(context, 'الباقة الفضية', '6 أشهر / 10,000 كم', '850 د.إ', [
            Icons.check_circle_outline,
            Icons.check_circle_outline,
          ]),
          Gap(16.w),
          _buildPackageCard(context, 'الباقة الذهبية', '12 شهر / 25,000 كم', '1,450 د.إ', [
            Icons.check_circle,
            Icons.check_circle,
            Icons.check_circle,
          ], isPremium: true),
        ],
      ),
    );
  }

  Widget _buildPackageCard(
    BuildContext context,
    String title,
    String duration,
    String price,
    List<IconData> checkIcons, {
    bool isPremium = false,
  }) {
    return Container(
      width: 250.w,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: isPremium ? AppColor.primaryColor(context) : AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: isPremium
            ? [
                BoxShadow(
                  color: AppColor.primaryColor(context).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              if (isPremium) Icon(Icons.star_rounded, color: Colors.amberAccent, size: 20.sp),
            ],
          ),
          Gap(8.h),
          Text(
            duration,
            style: AppTextStyle.bodySmall(
              context,
            ).copyWith(color: isPremium ? Colors.white70 : Colors.white38),
          ),
          Gap(20.h),
          Text(
            price,
            style: AppTextStyle.titleLarge(
              context,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.w900),
          ),
          Gap(20.h),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: isPremium ? Colors.white : AppColor.primaryColor(context),
              foregroundColor: isPremium ? AppColor.primaryColor(context) : Colors.white,
              minimumSize: Size(double.infinity, 45.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              elevation: 0,
            ),
            child: Text(
              AppLocaleKey.bookService.tr(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
