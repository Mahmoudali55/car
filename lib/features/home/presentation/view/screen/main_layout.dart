import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/features/home/presentation/view/screen/all_brands_screen.dart';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CarsScreen(),
    const BrandsScreen(),
    const OffersScreen(),
    const ServicesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.person, color: AppColor.primaryColor(context)),
        ),
        title: Text(AppLocaleKey.welcomeToCarGroup.tr(), style: AppTextStyle.titleMedium(context)),
        actions: [
          CircleAvatar(
            backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: AppColor.blackTextColor(context)),
            ),
          ),
          Gap(10.w),
          CircleAvatar(
            backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications, color: AppColor.blackTextColor(context)),
            ),
          ),
          Gap(5.w),
        ],
      ),
      body: _screens[_currentIndex.clamp(0, _screens.length - 1)],
      bottomNavigationBar: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavItem(0, Icons.home_outlined, Icons.home, AppLocaleKey.home.tr()),
            _buildNavItem(1, Icons.directions_car_outlined, Icons.directions_car, AppLocaleKey.cars.tr()),
            _buildNavItem(2, Icons.grid_view_rounded, Icons.grid_view_rounded, AppLocaleKey.brands.tr()),
            _buildNavItem(3, Icons.local_offer_outlined, Icons.local_offer, AppLocaleKey.latestOffers.tr()),
            _buildNavItem(4, Icons.miscellaneous_services_outlined, Icons.miscellaneous_services, AppLocaleKey.services.tr()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor(context).withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColor.primaryColor(context) : Colors.grey,
              size: 24.w,
            ),
            if (isSelected) ...[
              Gap(8.w),
              Text(
                label,
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.primaryColor(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 10.sp,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class CarsScreen extends StatelessWidget {
  const CarsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocaleKey.cars.tr()));
  }
}

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const AllBrandsScreen();
  }
}

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocaleKey.latestOffers.tr()));
  }
}

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(AppLocaleKey.services.tr()));
  }
}
