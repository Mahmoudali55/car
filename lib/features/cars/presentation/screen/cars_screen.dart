import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  final PageController _pageController = PageController();
  int _currentSliderIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
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
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            children: [
              Expanded(
                child: CustomFormField(
                  hintText: 'ابحث عن سيارة أحلامك...',
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
              Gap(12.w),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: const Icon(Icons.tune_rounded, color: Colors.white),
              ),
            ],
          ),
        ),

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              // Featured Slider
              _buildFeaturedSlider(),
              Gap(24.h),

              // Categories Quick Access
              _buildCategoriesRow(),
              Gap(24.h),

              // Cars List
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'السيارات المتاحة',
                      style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'عرض الكل',
                      style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.primaryColor(context)),
                    ),
                  ],
                ),
              ),
              Gap(16.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                itemCount: _carsList.length,
                separatorBuilder: (context, index) => Gap(16.h),
                itemBuilder: (context, index) {
                  return _buildPremiumCarCard(_carsList[index]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFeaturedSlider() {
    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentSliderIndex = index),
            itemCount: _featuredCars.length,
            itemBuilder: (context, index) {
              return _buildSliderItem(_featuredCars[index]);
            },
          ),
        ),
        Gap(12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _featuredCars.length,
            (index) => Container(
              margin: EdgeInsets.only(right: 6.w),
              height: 6.h,
              width: _currentSliderIndex == index ? 24.w : 6.w,
              decoration: BoxDecoration(
                color: _currentSliderIndex == index
                    ? AppColor.primaryColor(context)
                    : AppColor.greyColor(context).withOpacity(0.3),
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSliderItem(Map<String, String> car) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background Glow
          Positioned(
            right: -20,
            top: -20,
            child: Container(
              width: 150.w,
              height: 150.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor(context),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'عرض خاص',
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(8.h),
                      Text(
                        car['name']!,
                        style: AppTextStyle.titleMedium(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4.h),
                      Text(
                        car['price']!,
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Hero(
                    tag: 'featured_car_${car['name']}',
                    child: Image.asset(car['image']!, fit: BoxFit.contain),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesRow() {
    final categories = ['الكل', 'فاخرة', 'دفع رباعي', 'رياضية', 'سيدان'];
    return SizedBox(
      height: 45.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: categories.length,
        separatorBuilder: (context, index) => Gap(12.w),
        itemBuilder: (context, index) {
          bool isSelected = index == 0;
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColor.primaryColor(context) : AppColor.secondAppColor(context),
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.05),
              ),
            ),
            child: Text(
              categories[index],
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: isSelected ? Colors.white : Colors.white60,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPremiumCarCard(Map<String, dynamic> car) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'carDetailsScreen', arguments: car);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Stack(
              children: [
                // Car Image
                Container(
                  height: 160.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.blue.withOpacity(0.05),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Hero(
                    tag: 'car_image_${car['name']}',
                    child: Image.asset(car['image'], fit: BoxFit.contain),
                  ),
                ),
                // Badges
                Positioned(
                  top: 15.h,
                  left: 15.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      car['year'],
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 15.h,
                  right: 15.w,
                  child: Icon(
                    car['isFavorite'] ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                    color: car['isFavorite'] ? Colors.redAccent : Colors.white,
                    size: 22.sp,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car['brand'],
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            car['name'],
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        car['price'],
                        style: AppTextStyle.titleMedium(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Gap(12.h),
                  Divider(color: Colors.white.withOpacity(0.05), height: 1),
                  Gap(12.h),
                  Row(
                    children: [
                      _buildSpecIcon(Icons.speed_rounded, car['mileage']),
                      Gap(16.w),
                      _buildSpecIcon(Icons.settings_rounded, 'أوتوماتيك'),
                      Gap(16.w),
                      _buildSpecIcon(Icons.local_gas_station_rounded, 'بنزين'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecIcon(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.white38, size: 14.sp),
        Gap(4.w),
        Text(
          text,
          style: AppTextStyle.bodySmall(context).copyWith(
            color: Colors.white38,
            fontSize: 10.sp,
          ),
        ),
      ],
    );
  }
}
