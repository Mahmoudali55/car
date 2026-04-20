import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/home/presentation/view/widgets/ads_slider_widget.dart';
import 'package:car/features/home/presentation/view/widgets/budget_search_widget.dart';
import 'package:car/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:car/features/home/presentation/view/widgets/financing_banner_widget.dart';
import 'package:car/features/home/presentation/view/widgets/offers_grid_widget.dart';
import 'package:car/features/home/presentation/view/widgets/popular_cars_slider_widget.dart';
import 'package:car/features/home/presentation/view/widgets/recently_viewed_widget.dart';
import 'package:car/features/home/presentation/view/widgets/section_title_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:car/features/home/presentation/view/widgets/banks_slider_widget.dart';
import 'package:car/features/home/presentation/view/widgets/budget_cars_list_widget.dart';

class HomeGuestScreen extends StatefulWidget {
  const HomeGuestScreen({super.key});

  @override
  State<HomeGuestScreen> createState() => _HomeGuestScreenState();
}

class _HomeGuestScreenState extends State<HomeGuestScreen> {
  int _selectedBudgetIndex = 0;

  void _performAction(BuildContext context, VoidCallback action) {
    final token = HiveMethods.getToken();
    if (token != null && token.isNotEmpty) {
      action();
    } else {
      _showLoginDialog(context);
    }
  }

  void _showLoginDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocaleKey.login.tr()),
        content: Text(AppLocaleKey.loginToContinueYourPremiumExperience.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocaleKey.cancel.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              NavigatorMethods.pushNamed(context, RoutesName.loginScreen);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.primaryColor(context)),
            child: Text(AppLocaleKey.login.tr()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    const AdsSliderWidget(),
                    SizedBox(height: 15.h),
                  
                    SectionTitleWidget(
                      title: AppLocaleKey.categories.tr(),
                      onSeeAll: () {
                        Navigator.pushNamed(context, 'allBrandsScreen');
                      },
                    ),
                    SizedBox(height: 15.h),
                    const CategoriesWidget(),
                    SizedBox(height: 15.h),
                    SectionTitleWidget(
                      title: AppLocaleKey.popularCars.tr(),
                      onSeeAll: () {
                        NavigatorMethods.pushNamed(context, RoutesName.popularCarsScreen);
                      },
                    ),
                    SizedBox(height: 15.h),
                    const PopularCarsSlider(),
                    SizedBox(height: 20.h),
                    ValueListenableBuilder(
                      valueListenable: Hive.box('app').listenable(keys: ['recentlyViewed']),
                      builder: (context, box, _) {
                        final list = box.get('recentlyViewed', defaultValue: []) as List<dynamic>;
                        if (list.isEmpty) return const SizedBox.shrink();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SectionTitleWidget(title: AppLocaleKey.recentlyViewed.tr(), onSeeAll: null),
                            SizedBox(height: 15.h),
                            RecentlyViewedWidget(cars: list),
                            SizedBox(height: 20.h),
                          ],
                        );
                      },
                    ),
                    SectionTitleWidget(title: AppLocaleKey.searchByBudget.tr(), onSeeAll: null),
                    SizedBox(height: 15.h),
                      const BanksSliderWidget(),
                    SizedBox(height: 15.h),
                    BudgetSearchWidget(
                      initialIndex: _selectedBudgetIndex,
                      onChanged: (index) {
                        setState(() {
                          _selectedBudgetIndex = index;
                        });
                      },
                    ),
                    SizedBox(height: 20.h),
                    BudgetCarsListWidget(selectedBudgetIndex: _selectedBudgetIndex),
                    SizedBox(height: 30.h),
                    SectionTitleWidget(title: AppLocaleKey.trendingNow.tr()),
                    SizedBox(height: 15.h),
                    const OffersGridWidget(),
                    SizedBox(height: 120.h),
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
