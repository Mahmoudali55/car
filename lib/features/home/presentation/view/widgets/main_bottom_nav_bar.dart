import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MainBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;

  const MainBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MainNavItem(
            index: 0,
            currentIndex: currentIndex,
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: AppLocaleKey.home.tr(),
            onTap: () => onItemSelected(0),
          ),
          MainNavItem(
            index: 1,
            currentIndex: currentIndex,
            icon: Icons.directions_car_outlined,
            activeIcon: Icons.directions_car,
            label: AppLocaleKey.cars.tr(),
            onTap: () => onItemSelected(1),
          ),
          MainNavItem(
            index: 2,
            currentIndex: currentIndex,
            icon: Icons.favorite_outline_rounded,
            activeIcon: Icons.favorite_rounded,
            label: AppLocaleKey.favorites.tr(),
            onTap: () => onItemSelected(2),
          ),
          MainNavItem(
            index: 3,
            currentIndex: currentIndex,
            icon: Icons.local_offer_outlined,
            activeIcon: Icons.local_offer,
            label: AppLocaleKey.latestOffers.tr(),
            onTap: () => onItemSelected(3),
          ),
          MainNavItem(
            index: 4,
            currentIndex: currentIndex,
            icon: Icons.miscellaneous_services_outlined,
            activeIcon: Icons.miscellaneous_services,
            label: AppLocaleKey.services.tr(),
            onTap: () => onItemSelected(4),
          ),
        ],
      ),
    );
  }
}

class MainNavItem extends StatelessWidget {
  final int index;
  final int currentIndex;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final VoidCallback onTap;

  const MainNavItem({
    super.key,
    required this.index,
    required this.currentIndex,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isSelected = currentIndex == index;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primaryColor(context) : Colors.transparent,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? activeIcon : icon,
              color: isSelected ? AppColor.whiteColor(context) : AppColor.greyColor(context),
              size: 24.w,
            ),
            if (isSelected) ...[
              Gap(8.w),
              Text(
                label,
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.whiteColor(context),
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
