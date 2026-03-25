import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/favorites/presentation/view/screen/favorites_screen.dart';
import 'package:car/features/home/presentation/view/screen/all_brands_screen.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_cubit.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../cars/presentation/screen/cars_screen.dart';
import '../../../../offers/presentation/screen/offers_screen.dart';
import '../../../../services/presentation/screen/services_screen.dart';
import 'guest_home_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeGuestScreen(key: ValueKey('home_${context.locale.languageCode}')),
      CarsScreen(key: ValueKey('cars_${context.locale.languageCode}')),
      FavoritesScreen(key: ValueKey('favorites_${context.locale.languageCode}')),
      OffersScreen(key: ValueKey('offers_${context.locale.languageCode}')),
      ServicesScreen(key: ValueKey('services_${context.locale.languageCode}')),
    ];
    return Scaffold(
      appBar: CustomAppBar(
        context,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pushNamed(context, RoutesName.settingsScreen),
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
          BlocBuilder<NotificationsCubit, NotificationsState>(
            builder: (context, state) {
              final int unreadCount = state is NotificationsLoaded ? state.unreadCount : 0;
              return Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
                    child: IconButton(
                      onPressed: () => Navigator.pushNamed(context, RoutesName.notificationsScreen),
                      icon: Icon(
                        Icons.notifications_none_rounded,
                        color: AppColor.blackTextColor(context),
                      ),
                    ),
                  ),
                  if (unreadCount > 0)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Text(
                          unreadCount.toString(),
                          style: TextStyle(
                            color: AppColor.whiteColor(context),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Gap(10.w),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
                    child: IconButton(
                      onPressed: () => Navigator.pushNamed(context, RoutesName.cartScreen),
                      icon: Icon(
                        Icons.shopping_cart_outlined,
                        color: AppColor.blackTextColor(context),
                      ),
                    ),
                  ),
                  if (state.items.isNotEmpty)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: Text(
                          state.items.length.toString(),
                          style: TextStyle(
                            color: AppColor.whiteColor(context),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          Gap(10.w),
          CircleAvatar(
            backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
            child: IconButton(
              onPressed: () async {
                final newLocale = context.locale.languageCode == 'ar'
                    ? const Locale('en')
                    : const Locale('ar');
                await context.setLocale(newLocale);
                HiveMethods.updateLang(newLocale);
                if (mounted) setState(() {});
              },
              icon: Icon(
                Icons.translate_rounded,
                color: AppColor.blackTextColor(context),
                size: 20.sp,
              ),
            ),
          ),
          Gap(5.w),
        ],
      ),
      body: screens[_currentIndex.clamp(0, screens.length - 1)],
      bottomNavigationBar: Container(
        height: 75.h,
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor.whiteColor(context),
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
            _buildNavItem(0, Icons.home_outlined, Icons.home, AppLocaleKey.home.tr()),
            _buildNavItem(
              1,
              Icons.directions_car_outlined,
              Icons.directions_car,
              AppLocaleKey.cars.tr(),
            ),
            _buildNavItem(
              2,
              Icons.favorite_outline_rounded,
              Icons.favorite_rounded,
              AppLocaleKey.favorites.tr(),
            ),
            _buildNavItem(
              3,
              Icons.local_offer_outlined,
              Icons.local_offer,
              AppLocaleKey.latestOffers.tr(),
            ),
            _buildNavItem(
              4,
              Icons.miscellaneous_services_outlined,
              Icons.miscellaneous_services,
              AppLocaleKey.services.tr(),
            ),
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
              color: isSelected ? AppColor.primaryColor(context) : AppColor.greyColor(context),
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

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const AllBrandsScreen(isFromMainLayout: true);
  }
}
