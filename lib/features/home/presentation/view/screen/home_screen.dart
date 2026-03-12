import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),
      body: SingleChildScrollView(
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
                  _buildSectionTitle(context, AppLocaleKey.categories.tr(), () {
                    // Navigate to Brands tab (index 2) - will be handled by MainLayout
                    Navigator.pushNamed(context, 'allBrandsScreen');
                  }),
                  SizedBox(height: 15.h),
                  _buildCategories(context),
                  SizedBox(height: 30.h),
                  _buildSectionTitle(context, AppLocaleKey.latestOffers.tr(), () {}),
                  SizedBox(height: 15.h),
                  _buildFeaturedSlider(context),
                  SizedBox(height: 30.h),
                  _buildSectionTitle(context, AppLocaleKey.popularCars.tr(), () {}),
                  SizedBox(height: 15.h),
                  const PopularCarsSlider(),
                  SizedBox(height: 30.h),
                  _buildSectionTitle(context, AppLocaleKey.searchByBudget.tr(), null),
                  SizedBox(height: 15.h),
                  _buildBudgetSearch(context),
                  SizedBox(height: 30.h),
                  _buildSectionTitle(context, AppLocaleKey.trendingNow.tr(), () {}),
                  SizedBox(height: 15.h),
                  _buildOffersGrid(context),
                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBudgetSearch(BuildContext context) {
    final budgets = [
      AppLocaleKey.under50k.tr(),
      AppLocaleKey.k50k100k.tr(),
      AppLocaleKey.k100k200k.tr(),
      AppLocaleKey.over200k.tr(),
    ];

    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: budgets.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: AppColor.primaryColor(context).withOpacity(0.1)),
            ),
            child: Center(
              child: Text(
                budgets[index],
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback? onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold)),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              AppLocaleKey.seeAll.tr(),
              style: AppTextStyle.bodySmall(context, color: AppColor.primaryColor(context)),
            ),
          ),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    final categories = [
      {'name': AppLocaleKey.mercedes.tr(), 'image': 'assets/images/cars/mercedes-benz.png'},
      {'name': AppLocaleKey.bmw.tr(), 'image': 'assets/images/cars/bmw.png'},
      {'name': AppLocaleKey.toyota.tr(), 'image': 'assets/images/cars/toyota.png'},
      {'name': AppLocaleKey.tesla.tr(), 'image': 'assets/images/cars/tesla.png'},
      {'name': AppLocaleKey.audi.tr(), 'image': 'assets/images/cars/audi.png'},
      {'name': AppLocaleKey.nissan.tr(), 'image': 'assets/images/cars/nissan.png'},
      {'name': AppLocaleKey.ford.tr(), 'image': 'assets/images/cars/ford.png'},
      {'name': AppLocaleKey.hyundai.tr(), 'image': 'assets/images/cars/hyundai.png'},
      {'name': AppLocaleKey.volkswagen.tr(), 'image': 'assets/images/cars/volkswagen.png'},
      {'name': AppLocaleKey.kia.tr(), 'image': 'assets/images/cars/kia.png'},
      {'name': AppLocaleKey.lamborghini.tr(), 'image': 'assets/images/cars/lamborghini.png'},
      {'name': AppLocaleKey.porsche.tr(), 'image': 'assets/images/cars/porsche.png'},
      {'name': AppLocaleKey.mclaren.tr(), 'image': 'assets/images/cars/mclaren.png'},
      {'name': AppLocaleKey.bugatti.tr(), 'image': 'assets/images/cars/bugatti.png'},
      {'name': AppLocaleKey.jaguar.tr(), 'image': 'assets/images/cars/jaguar.png'},
      {'name': AppLocaleKey.mazda.tr(), 'image': 'assets/images/cars/mazda.png'},
    ];

    return SizedBox(
      height: 120.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(vertical: 5.h),
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 15.w),
        itemBuilder: (context, index) {
          return FadeInRight(
            delay: Duration(milliseconds: index * 100),
            child: Column(
              children: [
                Container(
                  width: 75.w,
                  height: 75.w,
                  padding: EdgeInsets.all(12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: AppColor.primaryColor(context).withOpacity(0.05),
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                      BoxShadow(
                        color: AppColor.primaryColor(context).withOpacity(0.03),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Image.asset(
                    categories[index]['image']!,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) =>
                        Icon(Icons.directions_car_rounded, color: AppColor.primaryColor(context)),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  categories[index]['name'] as String,
                  style: AppTextStyle.bodySmall(
                    context,
                    color: Colors.black87,
                  ).copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSlider(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _performAction(context, () {
                  // Action for authenticating users
                }),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColor.primaryColor(context),
                        AppColor.primaryColor(context).withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(25.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.primaryColor(context).withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -30.w,
                        bottom: -30.h,
                        child: Opacity(
                          opacity: 0.15,
                          child: Icon(Icons.speed_rounded, size: 200.w, color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(25.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.25),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                AppLocaleKey.specialOffer.tr().toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            Text(
                              "Porsche 911 GT3 RS",
                              style: AppTextStyle.titleLarge(context, color: Colors.white),
                            ),
                            SizedBox(height: 8.h),
                            Row(
                              children: [
                                Icon(Icons.timer_outlined, color: Colors.white70, size: 14.w),
                                SizedBox(width: 6.w),
                                Text(
                                  AppLocaleKey.limitedTime.tr(),
                                  style: AppTextStyle.bodySmall(context, color: Colors.white70),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "AED 980,000",
                                      style: AppTextStyle.titleMedium(context, color: Colors.white),
                                    ),
                                    Text(
                                      "Monthly from AED 12,500",
                                      style: TextStyle(color: Colors.white60, fontSize: 9.sp),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: EdgeInsets.all(10.w),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: AppColor.primaryColor(context),
                                    size: 16.w,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: index == 0 ? 20.w : 6.w,
              height: 6.w,
              decoration: BoxDecoration(
                color: index == 0 ? AppColor.primaryColor(context) : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOffersGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.68,
        crossAxisSpacing: 15.w,
        mainAxisSpacing: 15.h,
      ),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 15,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor(context).withOpacity(0.04),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.directions_car_rounded,
                          color: AppColor.primaryColor(context),
                          size: 55.w,
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        left: 12.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xffFF3B30),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            "-15%",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 12.h,
                        right: 12.w,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            color: Colors.grey,
                            size: 16.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mercedes G63 AMG",
                      style: AppTextStyle.titleSmall(context).copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        _buildCarDetail(context, Icons.calendar_today_outlined, "2024"),
                        SizedBox(width: 8.w),
                        _buildCarDetail(context, Icons.speed_outlined, "0 km"),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AED 850k",
                              style: AppTextStyle.titleSmall(
                                context,
                                color: AppColor.primaryColor(context),
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () => _performAction(context, () {
                            // Action for adding to cart or buying
                          }),
                          child: Container(
                            padding: EdgeInsets.all(6.w),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor(context),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primaryColor(context).withOpacity(0.4),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(Icons.add_rounded, color: Colors.white, size: 20.w),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCarDetail(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 12.w),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 10.sp),
        ),
      ],
    );
  }
}

class PopularCarsSlider extends StatefulWidget {
  const PopularCarsSlider({super.key});

  @override
  State<PopularCarsSlider> createState() => _PopularCarsSliderState();
}

class _PopularCarsSliderState extends State<PopularCarsSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, String>> popularCars = [
    {
      'name': 'Ferrari SF90',
      'image': 'assets/images/cars/mercedes-benz.png',
      'price': 'AED 1,200,000',
      'year': '2024',
      'km': '0 km',
      'engine': '4.0L V8',
    },
    {
      'name': 'Lamborghini Revuelto',
      'image': 'assets/images/cars/lamborghini.png',
      'price': 'AED 2,500,000',
      'year': '2024',
      'km': '0 km',
      'engine': '6.5L V12',
    },
    {
      'name': 'Porsche 911 GT3',
      'image': 'assets/images/cars/porsche.png',
      'price': 'AED 950,000',
      'year': '2024',
      'km': '0 km',
      'engine': '4.0L F6',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.85, initialPage: _currentPage);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < popularCars.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: popularCars.length,
        itemBuilder: (context, index) {
          final car = popularCars[index];
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                // Image Section (Flex 1)
                Expanded(
                  flex: 1,
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(12.w),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.greyColor(context).withOpacity(0.05),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.grey.withOpacity(0.2)),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(15.w),
                          child: Image.asset(car['image']!, fit: BoxFit.contain),
                        ),
                      ),
                      Positioned(
                        top: 20.h,
                        right: 20.w,
                        child: Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite_border_rounded,
                            color: AppColor.primaryColor(context),
                            size: 18.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Content Section (Flex 1)
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car['name']!,
                          style: AppTextStyle.titleMedium(
                            context,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        Gap(8.h),
                        // Details Row
                        Row(
                          children: [
                            _buildMiniDetail(context, Icons.calendar_today_outlined, car['year']!),
                            Gap(12.w),
                            _buildMiniDetail(context, Icons.speed_outlined, car['km']!),
                            Gap(12.w),
                            _buildMiniDetail(context, Icons.settings_outlined, car['engine']!),
                          ],
                        ),
                        const Spacer(),
                        // Price
                        Text(
                          car['price']!,
                          style: AppTextStyle.titleMedium(context).copyWith(
                            color: AppColor.primaryColor(context),
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Gap(10.h),
                        // Action Buttons
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColor.primaryColor(context),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  elevation: 0,
                                ),
                                child: Text(
                                  AppLocaleKey.orderNow.tr(),
                                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Gap(10.w),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {},
                                style: OutlinedButton.styleFrom(
                                  side: BorderSide(color: AppColor.primaryColor(context)),
                                  foregroundColor: AppColor.primaryColor(context),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.r),
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                ),
                                child: Text(
                                  AppLocaleKey.details.tr(),
                                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(10.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMiniDetail(BuildContext context, IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 14.w),
        Gap(4.w),
        Text(
          label,
          style: TextStyle(color: Colors.grey, fontSize: 10.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
