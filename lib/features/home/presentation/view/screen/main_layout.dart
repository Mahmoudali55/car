import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/favorites/presentation/view/screen/favorites_screen.dart';
import 'package:car/features/home/presentation/view/screen/all_brands_screen.dart';
import 'package:car/features/home/presentation/view/widgets/main_layout_actions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../cars/presentation/screen/cars_screen.dart';
import '../../../../offers/presentation/screen/offers_screen.dart';
import '../../../../services/presentation/screen/services_screen.dart';
import '../widgets/main_bottom_nav_bar.dart';
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
      appBar: _currentIndex == 4
          ? null
          : CustomAppBar(
              context,
              centerTitle: false,
              automaticallyImplyLeading: false,
              leading: const ProfileIconWidget(),
              title: Text(
                AppLocaleKey.welcomeToCarGroup.tr(),
                style: AppTextStyle.titleMedium(context),
              ),
              actions: [
                const SearchIconWidget(),
                Gap(10.w),
                const NotificationIconWidget(),
                Gap(10.w),
                const CartIconWidget(),
                Gap(10.w),
                const TranslateIconWidget(),
                Gap(5.w),
              ],
            ),
      body: screens[_currentIndex.clamp(0, screens.length - 1)],
      floatingActionButton: ValueListenableBuilder(
        valueListenable: Hive.box('app').listenable(keys: ['comparisonList']),
        builder: (context, box, _) {
          final list = box.get('comparisonList', defaultValue: []);
          if (list.isEmpty) return const SizedBox.shrink();

          return FloatingActionButton.extended(
            onPressed: () => Navigator.pushNamed(context, RoutesName.carComparisonScreen),
            backgroundColor: AppColor.primaryColor(context),
            icon: Icon(Icons.compare_arrows_rounded, color: Colors.white, size: 20.sp),
            label: Text(
              '${list.length}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
      bottomNavigationBar: MainBottomNavBar(
        currentIndex: _currentIndex,
        onItemSelected: (index) => setState(() => _currentIndex = index),
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
