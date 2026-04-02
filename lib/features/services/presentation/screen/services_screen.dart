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
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Minimalist Elite Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 40.h, 20.w, 20.h),
              child: FadeInDown(
                duration: const Duration(milliseconds: 600),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocaleKey.ourServices.tr(),
                          style: AppTextStyle.titleLarge(context).copyWith(
                            color: AppColor.blackTextColor(context),
                            fontWeight: FontWeight.w900,
                            fontSize: 28.sp,
                            letterSpacing: -0.5,
                          ),
                        ),
                        Gap(4.h),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(
                              color: AppColor.primaryColor(context).withValues(alpha: 0.2),
                            ),
                          ),
                          child: Text(
                            'ELITE HUB',
                            style: TextStyle(
                              color: AppColor.primaryColor(context),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Navigator.pushNamed(context, RoutesName.settingsScreen),
                      icon: Icon(
                        Icons.settings,
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.70),
                        size: 26.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // High-Contrast Hero: Sell Your Car
          SliverToBoxAdapter(
            child: FadeInUp(
              duration: const Duration(milliseconds: 800),
              child: _buildEliteHeroHighlight(context),
            ),
          ),

          // Quick Actions Label
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 16.h),
              child: FadeInLeft(
                child: Text(
                  AppLocaleKey.quickActions.tr(),
                  style: AppTextStyle.titleMedium(context).copyWith(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),

          // Horizontal Quick Actions
          SliverToBoxAdapter(
            child: SizedBox(
              height: 100.h,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _getQuickActions().length,
                itemBuilder: (context, index) {
                  final action = _getQuickActions()[index];
                  return FadeInRight(
                    delay: Duration(milliseconds: 100 * index),
                    child: _buildQuickActionItem(context, action),
                  );
                },
              ),
            ),
          ),

          // Main Services Section Title
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 32.h, 20.w, 16.h),
              child: FadeInLeft(
                child: Text(
                  AppLocaleKey.services.tr(),
                  style: AppTextStyle.titleMedium(context).copyWith(
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),

          // Vertical Immersive Service Cards
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final services = _getServicesData();
                return FadeInUp(
                  delay: Duration(milliseconds: 150 * index),
                  child: _buildImmersiveServiceCard(context, services[index], index),
                );
              }, childCount: _getServicesData().length),
            ),
          ),

          // Extra Space for overlap with bottom nav
          SliverToBoxAdapter(child: Gap(120.h)),
        ],
      ),
    );
  }

  Widget _buildEliteHeroHighlight(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      height: 200.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor(context),
            AppColor.primaryColor(context).withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor(context).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24.r),
        child: Stack(
          children: [
            // Side Car Visual (High Contrast)
            Positioned(
              right: -30.w,
              bottom: -10.h,
              child: Opacity(
                opacity: 0.8,
                child: Image.asset(
                  'assets/images/cars/aston-martin.png',
                  height: 160.h,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionItem(BuildContext context, Map<String, dynamic> action) {
    return GestureDetector(
      onTap: () {
        if (HiveMethods.getToken() == null) {
          CommonMethods.showLoginRequiredDialog(context);
        } else {
          _navigateToQuickAction(context, action['label']);
        }
      },
      child: Container(
        width: 85.w,
        margin: EdgeInsets.only(right: 12.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
              ),
              child: Icon(action['icon'], color: action['color'], size: 24.sp),
            ),
            Gap(8.h),
            Text(
              action['label'],
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.70),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImmersiveServiceCard(BuildContext context, Map<String, dynamic> service, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      height: 110.h,
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.03)),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            if (HiveMethods.getToken() == null) {
              CommonMethods.showLoginRequiredDialog(context);
            } else {
              _navigateToService(context, service['label']);
            }
          },
          borderRadius: BorderRadius.circular(22.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 70.w,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: (service['color'] as Color).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Icon(service['icon'], color: service['color'], size: 30.sp),
                ),
                Gap(16.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['label'],
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.blackTextColor(context),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        _getServiceDescription(service['label']),
                        style: TextStyle(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
                          fontSize: 11.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: AppColor.blackTextColor(context).withValues(alpha: 0.10),
                  size: 16.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getQuickActions() {
    return [
      {
        'icon': Icons.car_rental_rounded,
        'label': AppLocaleKey.requestCar.tr(),
        'color': Colors.blueAccent,
      },
      {
        'icon': Icons.calendar_month_rounded,
        'label': AppLocaleKey.bookAppointments.tr(),
        'color': Colors.orangeAccent,
      },
      {
        'icon': Icons.history_rounded,
        'label': AppLocaleKey.myHistory.tr(),
        'color': Colors.greenAccent,
      },
      {
        'icon': Icons.support_agent_rounded,
        'label': AppLocaleKey.support.tr(),
        'color': Colors.purpleAccent,
      },
    ];
  }

  List<Map<String, dynamic>> _getServicesData() {
    return [
      {
        'icon': Icons.directions_car_filled_rounded,
        'label': AppLocaleKey.requestCar.tr(),
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
      {
        'icon': Icons.analytics_rounded,
        'label': AppLocaleKey.carValuation.tr(),
        'color': Colors.amber,
      },
      {
        'icon': Icons.info_outline_rounded,
        'label': AppLocaleKey.aboutCompany.tr(),
        'color': Colors.blueGrey,
      },
    ];
  }

  String _getServiceDescription(String label) {
    if (label == AppLocaleKey.requestCar.tr()) {
      return AppLocaleKey.requestCarDesc.tr();
    }
    if (label == AppLocaleKey.importOnDemand.tr()) {
      return AppLocaleKey.importOnDemandDesc.tr();
    }
    if (label == AppLocaleKey.financingSolutions.tr()) {
      return AppLocaleKey.financingSolutionsDesc.tr();
    }
    if (label == AppLocaleKey.showroomShine.tr()) {
      return AppLocaleKey.showroomShineDesc.tr();
    }
    if (label == AppLocaleKey.vipShipping.tr()) {
      return AppLocaleKey.vipShippingDesc.tr();
    }
    if (label == AppLocaleKey.bespokeSelection.tr()) {
      return AppLocaleKey.bespokeSelectionDesc.tr();
    }
    return AppLocaleKey.defaultServiceDesc.tr();
  }

  void _navigateToService(BuildContext context, String label) {
    if (label == AppLocaleKey.requestCar.tr()) {
      Navigator.pushNamed(context, RoutesName.requestCarScreen);
    } else if (label == AppLocaleKey.importOnDemand.tr()) {
      Navigator.pushNamed(context, RoutesName.importOnDemandScreen);
    } else if (label == AppLocaleKey.financingSolutions.tr()) {
      Navigator.pushNamed(context, RoutesName.financingScreen);
    } else if (label == AppLocaleKey.showroomShine.tr()) {
      Navigator.pushNamed(context, RoutesName.carDetailingScreen);
    } else if (label == AppLocaleKey.vipShipping.tr()) {
      Navigator.pushNamed(context, RoutesName.shippingScreen);
    } else if (label == AppLocaleKey.bespokeSelection.tr()) {
      Navigator.pushNamed(context, RoutesName.bespokeSelectionScreen);
    } else if (label == AppLocaleKey.carValuation.tr() || label == AppLocaleKey.valuation.tr()) {
      Navigator.pushNamed(context, RoutesName.carValuationScreen);
    } else if (label == AppLocaleKey.aboutCompany.tr()) {
      Navigator.pushNamed(context, RoutesName.aboutScreen);
    }
  }

  void _navigateToQuickAction(BuildContext context, String label) {
    if (label == AppLocaleKey.requestCar.tr()) {
      Navigator.pushNamed(context, RoutesName.requestCarScreen);
    } else if (label == AppLocaleKey.bookAppointments.tr()) {
      Navigator.pushNamed(context, RoutesName.bookingAppointmentScreen);
    } else if (label == AppLocaleKey.myHistory.tr()) {
      Navigator.pushNamed(context, RoutesName.serviceHistoryScreen);
    } else if (label == AppLocaleKey.support.tr()) {
      Navigator.pushNamed(context, RoutesName.supportScreen);
    }
  }
}
