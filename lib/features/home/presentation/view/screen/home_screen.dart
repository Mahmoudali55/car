import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
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
      appBar: CustomAppBar(
        context,
        centerTitle: true,
        automaticallyImplyLeading: true,
        leading: CircleAvatar(
          backgroundColor: AppColor.primaryColor(context),
          child: Icon(Icons.person, color: AppColor.whiteColor(context)),
        ),
        title: Text(AppLocaleKey.home.tr(), style: AppTextStyle.titleMedium(context)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: AppColor.primaryColor(context)),
          ),
        ],
      ),
      backgroundColor: const Color(0xffF8F9FB),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 20.h),
                width: 200.w,
                height: 30.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.blackTextColor(context)),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: Icon(Icons.person, color: AppColor.blackTextColor(context)),
                      ),
                      Gap(10.w),
                      Text(
                        AppLocaleKey.loginContinue.tr(),
                        style: AppTextStyle.bodySmall(
                          context,
                          color: AppColor.blackTextColor(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    radius: 12.r,
                    prefixIcon: Icon(Icons.search, color: AppColor.primaryColor(context)),
                    hintText: AppLocaleKey.findCar.tr(),
                  ),

                  SizedBox(height: 30.h),
                  _buildSectionTitle(context, AppLocaleKey.categories.tr(), null),
                  SizedBox(height: 15.h),
                  _buildCategories(context),
                  SizedBox(height: 30.h),
                  _buildSectionTitle(context, AppLocaleKey.latestOffers.tr(), () {}),
                  SizedBox(height: 15.h),
                  _buildFeaturedSlider(context),
                  SizedBox(height: 30.h),
                  _buildSectionTitle(context, AppLocaleKey.searchByBodyType.tr(), null),
                  SizedBox(height: 15.h),
                  _buildBodyTypeSearch(context),
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

  Widget _buildBodyTypeSearch(BuildContext context) {
    final bodyTypes = [
      {'name': AppLocaleKey.suv.tr(), 'icon': Icons.directions_car_rounded},
      {'name': AppLocaleKey.sedan.tr(), 'icon': Icons.directions_car_rounded},
      {'name': AppLocaleKey.sports.tr(), 'icon': Icons.speed_rounded},
      {'name': AppLocaleKey.coupe.tr(), 'icon': Icons.directions_car_rounded},
      {'name': AppLocaleKey.hatchback.tr(), 'icon': Icons.directions_car_rounded},
      {'name': AppLocaleKey.convertible.tr(), 'icon': Icons.brightness_high_rounded},
      {'name': AppLocaleKey.truck.tr(), 'icon': Icons.local_shipping_rounded},
      {'name': AppLocaleKey.van.tr(), 'icon': Icons.airport_shuttle_rounded},
    ];

    return SizedBox(
      height: 90.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: bodyTypes.length,
        separatorBuilder: (context, index) => SizedBox(width: 15.w),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  bodyTypes[index]['icon'] as IconData,
                  color: AppColor.primaryColor(context),
                  size: 28.w,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                bodyTypes[index]['name'] as String,
                style: AppTextStyle.bodySmall(
                  context,
                ).copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500),
              ),
            ],
          );
        },
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
