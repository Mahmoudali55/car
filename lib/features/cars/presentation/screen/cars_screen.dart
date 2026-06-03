import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/cars/data/model/brand_model.dart';
import 'package:car/features/cars/presentation/screen/widget/car_search_header_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/cars_categories_row_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/cars_list_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/featured_cars_slider_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/section_header_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
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
  BrandModel? _selectedBrand;

  static const List<Map<String, String>> _featuredCars = [
    {
      'image': 'https://images.unsplash.com/photo-1520031441872-265e4ff70366?q=80&w=800',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'price': '850,000',
      'installments': '1,166',
    },
    {
      'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=800',
      'name': 'M5 Competition',
      'brand': 'BMW',
      'price': '520,000',
      'installments': '1,166',
    },
    {
      'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?q=80&w=800',
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'price': '480,000',
      'installments': '1,166',
    },
  ];

  static final List<GetBrandCarsDataModel> _carsList = [
    GetBrandCarsDataModel.fromJson({
      'image': 'https://images.unsplash.com/photo-1520031441872-265e4ff70366?q=80&w=800',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'price': '850,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': true,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    }),
    GetBrandCarsDataModel.fromJson({
      'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=800',
      'name': 'M5 Competition',
      'brand': 'BMW',
      'price': '520,000',
      'year': '2023',
      'mileage': '5,000',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    }),
    GetBrandCarsDataModel.fromJson({
      'image': 'https://images.unsplash.com/photo-1594502184342-2e12f877aa73?q=80&w=800',
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'price': '350,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    }),
    GetBrandCarsDataModel.fromJson({
      'image': 'https://images.unsplash.com/photo-1560958089-b8a1929cea89?q=80&w=800',
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'price': '480,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    }),
    GetBrandCarsDataModel.fromJson({
      'image': 'https://images.unsplash.com/photo-1614200187524-dc4b892acf16?q=80&w=800',
      'name': 'RS e-tron GT',
      'brand': 'Audi',
      'price': '550,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': true,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    }),
  ];
  List<String> get _categories => [
    AppLocaleKey.all.tr(),
    AppLocaleKey.luxury.tr(),
    AppLocaleKey.suv.tr(),
    AppLocaleKey.sports.tr(),
    AppLocaleKey.sedan.tr(),
  ];
  List<GetBrandCarsDataModel> get _filteredCars {
    if (_selectedBrand == null) return _carsList;
    return _carsList.where((car) => car.groupName == _selectedBrand!.name).toList();
  }

  GetBrandCarsDataModel _localizeCarData(GetBrandCarsDataModel car) {
    // Note: Since GetBrandCarsDataModel uses getters for formatted data in PremiumCarCardWidget,
    // we don't strictly need to modify the model here unless we want to change its core price field.
    return car;
  }

  Map<String, String> _localizeFeaturedCar(Map<String, String> car) {
    return {
      ...car,
      'price': '${car['price']} ${AppLocaleKey.sar.tr()}',
      'installments':
          '${car['installments']} ${AppLocaleKey.sar.tr()} / ${AppLocaleKey.month.tr()}',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CarSearchHeaderWidget(),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              FeaturedCarsSliderWidget(
                featuredCars: _featuredCars.map(_localizeFeaturedCar).toList(),
              ),
              Gap(24.h),
              CarsCategoriesRowWidget(
                selectedIndex: _selectedCategoryIndex,
                categories: _categories,
                onCategorySelected: (index) => setState(() => _selectedCategoryIndex = index),
              ),
              Gap(24.h),
              const SectionHeader(),
              Gap(16.h),
              CarsList(cars: _filteredCars, localizeCarData: _localizeCarData),
            ],
          ),
        ),
      ],
    );
  }
}
