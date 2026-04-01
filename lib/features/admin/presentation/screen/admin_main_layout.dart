import 'dart:ui';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/admin_dashboard_screen.dart';
import 'package:car/features/admin/presentation/screen/admin_settings_screen.dart';
import 'package:car/features/admin/presentation/screen/manage_bookings_screen.dart';
import 'package:car/features/admin/presentation/screen/manage_cars_screen.dart';
import 'package:car/features/admin/presentation/screen/revenue_report_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminMainLayout extends StatefulWidget {
  const AdminMainLayout({super.key});

  @override
  State<AdminMainLayout> createState() => _AdminMainLayoutState();
}

class _AdminMainLayoutState extends State<AdminMainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AdminDashboardScreen(),
    const ManageCarsScreen(),
    const ManageBookingsScreen(),
    const RevenueReportScreen(),
    const AdminSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 90.h,
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context).withValues(alpha: 0.8),
        border: Border(top: BorderSide(color: AppColor.blackTextColor(context).withValues(alpha: 0.05))),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.dashboard_rounded, AppLocaleKey.home.tr()),
                _buildNavItem(1, Icons.directions_car_rounded, AppLocaleKey.cars.tr()),
                _buildNavItem(2, Icons.calendar_month_rounded, AppLocaleKey.bookingsAndTrips.tr()),
                _buildNavItem(3, Icons.payments_rounded, AppLocaleKey.financialReports.tr()),
                _buildNavItem(4, Icons.settings_rounded, AppLocaleKey.settings.tr()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    bool isSelected = _currentIndex == index;
    Color color = isSelected ? AppColor.primaryColor(context) : AppColor.blackTextColor(context).withValues(alpha: 0.4);

    return Expanded(
      child: InkWell(
        onTap: () => setState(() => _currentIndex = index),
        borderRadius: BorderRadius.circular(20.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColor.primaryColor(context).withValues(alpha: 0.1) : Colors.transparent,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 24.sp),
              Gap(4.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 10.sp,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
