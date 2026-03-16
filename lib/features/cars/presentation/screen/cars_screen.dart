import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/screen/widget/car_search_header_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/cars_categories_row_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/featured_cars_slider_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/premium_car_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  int _selectedCategoryIndex = 0;
  final List<String> _categories = ['الكل', 'فاخرة', 'دفع رباعي', 'رياضية', 'سيدان'];

  @override
  void dispose() {
    super.dispose();
  }

  // Dummy slider data
  final List<Map<String, String>> _featuredCars = [
    {
      'image': 'assets/images/cars/mercedes-benz.png',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'price': '850,000 د.إ',
    },
    {
      'image': 'assets/images/cars/bmw.png',
      'name': 'M5 Competition',
      'brand': 'BMW',
      'price': '520,000 د.إ',
    },
    {
      'image': 'assets/images/cars/tesla.png',
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'price': '480,000 د.إ',
    },
  ];

  // Dummy car list data
  final List<Map<String, dynamic>> _carsList = [
    {
      'image': 'assets/images/cars/mercedes-benz.png',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'price': '850,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'isFavorite': true,
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'image': 'assets/images/cars/bmw.png',
      'name': 'M5 Competition',
      'brand': 'BMW',
      'price': '520,000 د.إ',
      'year': '2023',
      'mileage': '5,000 كم',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'image': 'assets/images/cars/toyota.png',
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'price': '350,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'image': 'assets/images/cars/tesla.png',
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'price': '480,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
    },
    {
      'image': 'assets/images/cars/audi.png',
      'name': 'RS e-tron GT',
      'brand': 'Audi',
      'price': '550,000 د.إ',
      'year': '2024',
      'mileage': '0 كم',
      'isFavorite': true,
      'video_id': 'D7O8J5vVf-M',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Search & Filter Header
        const CarSearchHeaderWidget(),

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              // Featured Slider
              FeaturedCarsSliderWidget(featuredCars: _featuredCars),
              Gap(24.h),

              // Categories Row (Selection)
              CarsCategoriesRowWidget(
                selectedIndex: _selectedCategoryIndex,
                categories: _categories,
                onCategorySelected: (index) {
                  setState(() {
                    _selectedCategoryIndex = index;
                  });
                },
              ),
              Gap(24.h),

              // Cars List Label
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocaleKey.availableCars.tr(),
                      style: AppTextStyle.titleMedium(
                        context,
                      ).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      AppLocaleKey.showAll.tr(),
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.primaryColor(context)),
                    ),
                  ],
                ),
              ),
              Gap(16.h),

              // Cars List
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                itemCount: _carsList.length,
                separatorBuilder: (context, index) => Gap(16.h),
                itemBuilder: (context, index) {
                  return PremiumCarCardWidget(car: _carsList[index]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
