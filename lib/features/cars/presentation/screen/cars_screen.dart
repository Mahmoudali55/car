import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/data/model/brand_model.dart';
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
  BrandModel? _selectedBrand;

  // ─── Dummy Data ───────────────────────────────────

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
      'image': 'https://images.unsplash.com/photo-1617788131775-ddb49554618a?q=80&w=800',
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'price': '480,000',
      'installments': '1,166',
    },
  ];

  static const List<Map<String, dynamic>> _carsList = [
    {
      'image': 'https://images.unsplash.com/photo-1520031441872-265e4ff70366?q=80&w=800',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'price': '850,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': true,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    },
    {
      'image': 'https://images.unsplash.com/photo-1555215695-3004980ad54e?q=80&w=800',
      'name': 'M5 Competition',
      'brand': 'BMW',
      'price': '520,000',
      'year': '2023',
      'mileage': '5,000',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    },
    {
      'image': 'https://images.unsplash.com/photo-1594502184342-2e12f877aa73?q=80&w=800',
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'price': '350,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    },
    {
      'image': 'https://images.unsplash.com/photo-1617788131775-ddb49554618a?q=80&w=800',
      'name': 'Model S Plaid',
      'brand': 'Tesla',
      'price': '480,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': false,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    },
    {
      'image': 'https://images.unsplash.com/photo-1614200187524-dc4b892acf16?q=80&w=800',
      'name': 'RS e-tron GT',
      'brand': 'Audi',
      'price': '550,000',
      'year': '2024',
      'mileage': '0',
      'isFavorite': true,
      'video_id': 'D7O8J5vVf-M',
      'installments': '1,166',
    },
  ];

  // ─── Helpers ─────────────────────────────────────

  List<String> get _categories => [
    AppLocaleKey.all.tr(),
    AppLocaleKey.luxury.tr(),
    AppLocaleKey.suv.tr(),
    AppLocaleKey.sports.tr(),
    AppLocaleKey.sedan.tr(),
  ];

  List<Map<String, dynamic>> get _filteredCars {
    if (_selectedBrand == null) return _carsList;
    return _carsList.where((car) => car['brand'] == _selectedBrand!.name).toList();
  }

  /// إضافة وحدات السعر والمسافة عند العرض — بدل تلويث الـ data بمسافات زيادة
  Map<String, dynamic> _localizeCarData(Map<String, dynamic> car) {
    return {
      ...car,
      'price': '${car['price']} ${AppLocaleKey.sar.tr()}',
      'mileage': '${car['mileage']} ${AppLocaleKey.km.tr()}',
      'installments':
          '${car['installments']} ${AppLocaleKey.sar.tr()} / ${AppLocaleKey.month.tr()}',
    };
  }

  Map<String, String> _localizeFeaturedCar(Map<String, String> car) {
    return {
      ...car,
      'price': '${car['price']} ${AppLocaleKey.sar.tr()}',
      'installments':
          '${car['installments']} ${AppLocaleKey.sar.tr()} / ${AppLocaleKey.month.tr()}',
    };
  }

  // ─── Build ────────────────────────────────────────

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
              _SectionHeader(),
              Gap(16.h),
              _CarsList(cars: _filteredCars, localizeCarData: _localizeCarData),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocaleKey.availableCars.tr(),
            style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            AppLocaleKey.showAll.tr(),
            style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.primaryColor(context)),
          ),
        ],
      ),
    );
  }
}

class _CarsList extends StatelessWidget {
  const _CarsList({required this.cars, required this.localizeCarData});

  final List<Map<String, dynamic>> cars;
  final Map<String, dynamic> Function(Map<String, dynamic>) localizeCarData;

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: Center(
          child: Text(
            AppLocaleKey.noCarsForBrand.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.4)),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
      itemCount: cars.length,
      separatorBuilder: (_, __) => Gap(16.h),
      itemBuilder: (context, index) {
        final car = localizeCarData(cars[index]);
        return PremiumCarCardWidget(
          car: car,
          heroTag: 'premium_car_image_${car['itemCode'] ?? car['name']}',
        );
      },
    );
  }
}
