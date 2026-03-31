import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/home/presentation/view/widgets/budget_search_widget.dart';
import 'package:car/features/home/presentation/view/widgets/categories_widget.dart';
import 'package:car/features/home/presentation/view/widgets/financing_banner_widget.dart';
import 'package:car/features/home/presentation/view/widgets/offers_grid_widget.dart';
import 'package:car/features/home/presentation/view/widgets/popular_cars_slider_widget.dart';
import 'package:car/features/home/presentation/view/widgets/section_title_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeGuestScreen extends StatelessWidget {
  const HomeGuestScreen({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                SectionTitleWidget(
                  title: AppLocaleKey.categories.tr(),
                  onSeeAll: () {
                    // Navigate to Brands tab (index 2) - will be handled by MainLayout
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
                const FinancingBannerWidget(),
                SizedBox(height: 30.h),
                SectionTitleWidget(title: AppLocaleKey.searchByBudget.tr(), onSeeAll: null),
                SizedBox(height: 15.h),
                const BudgetSearchWidget(),
                SizedBox(height: 30.h),
                SectionTitleWidget(title: AppLocaleKey.trendingNow.tr()),
                SizedBox(height: 15.h),
                const OffersGridWidget(),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
