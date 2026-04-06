import 'dart:async';

import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PopularCarsSlider extends StatefulWidget {
  const PopularCarsSlider({super.key});

  @override
  State<PopularCarsSlider> createState() => _PopularCarsSliderState();
}

class _PopularCarsSliderState extends State<PopularCarsSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> popularCars = [
    {
      'name': 'Ferrari SF90',
      'image': 'assets/images/cars/mercedes-benz.png', // Temporary fallback image
      'brand': 'Ferrari',
      'price': '1,200,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
    },
    {
      'name': 'Lamborghini Revuelto',
      'brand': 'Lamborghini',
      'image': 'assets/images/cars/lamborghini.png',
      'price': '2,500,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '6.5L V12',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'name': 'Porsche 911 GT3',
      'brand': 'Porsche',
      'image': 'assets/images/cars/porsche.png',
      'price': '950,000  ر.س       ',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L F6',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
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

  void _navigateToDetails(BuildContext context, Map<String, dynamic> car) {
    NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520.h,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) => setState(() => _currentPage = value),
        itemCount: popularCars.length,
        itemBuilder: (context, index) {
          final car = popularCars[index];
          final isSelected = index == _currentPage;

          return GestureDetector(
            onTap: () => _navigateToDetails(context, car),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutQuint,
              margin: EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: isSelected ? 10.h : 20.h, // Scale effect for non-selected items
              ),
              decoration: BoxDecoration(
                color: AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(28.r),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? AppColor.primaryColor(context).withOpacity(0.15)
                        : Colors.black.withOpacity(0.1),
                    blurRadius: isSelected ? 20 : 10,
                    offset: isSelected ? const Offset(0, 10) : const Offset(0, 5),
                  ),
                ],
                border: Border.all(
                  color: isSelected
                      ? AppColor.primaryColor(context).withOpacity(0.3)
                      : AppColor.blackTextColor(context).withOpacity(0.05),
                  width: 1,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  // Image Section
                  Expanded(
                    flex: 10,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        // Subdued background for the image
                        Container(
                          color: AppColor.blackTextColor(context).withOpacity(0.02),
                          padding: EdgeInsets.all(16.w),
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 400),
                            scale: isSelected ? 1.05 : 0.95, // Slight zoom effect
                            child: Hero(
                              tag: 'car_image_${car['name']}',
                              child: Center(
                                child: Image.asset(
                                  car['image']!,
                                  fit: BoxFit.contain,
                                  height: 100.h,
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Bottom gradient to blend into details
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 40.h,
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                colors: [
                                  AppColor.secondAppColor(context),
                                  AppColor.secondAppColor(context).withOpacity(0.0),
                                ],
                              ),
                            ),
                          ),
                        ),

                        // Favorite Icon
                        Positioned(
                          top: 16.h,
                          right: 16.w,
                          child: BlocBuilder<FavoritesCubit, FavoritesState>(
                            builder: (context, state) {
                              final isFav = context.read<FavoritesCubit>().isFavorite(car['name']!);
                              return GestureDetector(
                                onTap: () {
                                  context.read<FavoritesCubit>().toggleFavorite(car);
                                },
                                child: CircleAvatar(
                                  radius: 16.r,
                                  backgroundColor: AppColor.blackTextColor(
                                    context,
                                  ).withValues(alpha: 0.1),
                                  child: Icon(
                                    isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                    color: isFav
                                        ? Colors.redAccent
                                        : AppColor.blackTextColor(context),
                                    size: 18.w,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        // "Hot Deal" Badge
                        Positioned(
                          top: 16.h,
                          left: 16.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor(context).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                color: AppColor.primaryColor(context).withOpacity(0.5),
                              ),
                            ),
                            child: Text(
                              AppLocaleKey.mostRequested.tr(),
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: AppColor.primaryColor(context),
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Content Section
                  Expanded(
                    flex: 15,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 16.h),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          width: 280.w, // Fixed content width for FittedBox calculation
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                car['name']!,
                                style: AppTextStyle.titleMedium(context).copyWith(
                                  color: AppColor.blackTextColor(context),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Gap(12.h),

                              // Technical specs
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildMiniDetail(
                                    context,
                                    Icons.calendar_today_outlined,
                                    car['year']!,
                                  ),
                                  _buildMiniDetail(context, Icons.speed_outlined, car['mileage']!),
                                  _buildMiniDetail(context, Icons.settings_outlined, car['engine']!),
                                ],
                              ),

                              Gap(16.h),

                              // Price
                              Text(
                                car['price']!,
                                style: AppTextStyle.titleMedium(context).copyWith(
                                  color: AppColor.primaryColor(context),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 19.sp,
                                ),
                              ),
                              Gap(12.h),

                              // Action Buttons
                              Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: CustomButton(
                                      onPressed: () => _navigateToDetails(context, car),
                                      child: Text(
                                        AppLocaleKey.orderNow.tr(),
                                        style: AppTextStyle.bodyMedium(context).copyWith(
                                          color: AppColor.whiteColor(context),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Gap(12.w),
                                  Expanded(
                                    flex: 2,
                                    child: OutlinedButton(
                                      onPressed: () => _navigateToDetails(context, car),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                          color: AppColor.blackTextColor(context).withOpacity(0.2),
                                          width: 1.5,
                                        ),
                                        foregroundColor: AppColor.blackTextColor(context),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16.r),
                                        ),
                                        padding: EdgeInsets.symmetric(vertical: 12.h),
                                      ),
                                      child: Text(
                                        AppLocaleKey.details.tr(),
                                        style: AppTextStyle.bodySmall(context).copyWith(
                                          color: AppColor.blackTextColor(context),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildMiniDetail(BuildContext context, IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withOpacity(0.04),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.02)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColor.greyColor(context), size: 14.w),
          Gap(6.w),
          Text(
            label,
            style: TextStyle(
              color: AppColor.greyColor(context),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
