import 'dart:async';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
