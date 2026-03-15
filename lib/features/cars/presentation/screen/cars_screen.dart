import 'dart:async';
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
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'فاخرة', 'رياضية', 'SUV', 'سيدان'];

  late PageController _pageController;
  int _currentBannerIndex = 0;
  late Timer _timer;

  // Data for the animated hero slider
  final List<Map<String, dynamic>> _featuredCars = [
    {
      'badge': 'وصل حديثاً',
      'title': 'اكتشف الفخامة المطلقة مع أحدث طرازات مرسيدس',
      'icon': Icons.diamond_outlined,
      'colors': [const Color(0xFF1E293B), const Color(0xFF334155).withOpacity(0.8)], // Dark slate theme
    },
    {
      'badge': 'الأكثر طلباً',
      'title': 'أداء لا يضاهى مع سيارات بورش الرياضية',
      'icon': Icons.speed_rounded,
      'colors': [const Color(0xFFB91C1C), const Color(0xFFEF4444).withOpacity(0.7)], // Red theme
    },
    {
      'badge': 'سيارات SUV',
      'title': 'رحلات عائلية بقمة الراحة والأمان',
      'icon': Icons.family_restroom_rounded,
      'colors': [const Color(0xFF0F766E), const Color(0xFF14B8A6).withOpacity(0.7)], // Teal theme
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentBannerIndex);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentBannerIndex < _featuredCars.length - 1) {
        _currentBannerIndex++;
      } else {
        _currentBannerIndex = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentBannerIndex,
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

  // Dummy premium data
  final List<Map<String, dynamic>> _cars = [
    {
      'brand': 'Mercedes-Benz',
      'name': 'G-Class G63 AMG',
      'price': '850,000 درهم',
      'year': '2023',
      'mileage': '12,000 كم',
      'image':
          'assets/images/cars/mercedes-benz.png', // Fallback to a brand logo if real image is missing
      'isFavorite': false,
    },
    {
      'brand': 'Porsche',
      'name': '911 Turbo S',
      'price': '920,000 درهم',
      'year': '2024',
      'mileage': '5,000 كم',
      'image': 'assets/images/cars/porsche.png',
      'isFavorite': true,
    },
    {
      'brand': 'BMW',
      'name': 'M8 Competition',
      'price': '650,000 درهم',
      'year': '2022',
      'mileage': '24,000 كم',
      'image': 'assets/images/cars/bmw.png',
      'isFavorite': false,
    },
    {
      'brand': 'Audi',
      'name': 'RS Q8',
      'price': '580,000 درهم',
      'year': '2023',
      'mileage': '18,000 كم',
      'image': 'assets/images/cars/audi.png',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
              child: CustomFormField(
                radius: 16.r,
                onChanged: (val) {},
                prefixIcon: const Icon(Icons.search),
                hintText: 'ابحث عن سيارة أحلامك...',
              ),
            ),

            // Filter Chips
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _filters.length,
                separatorBuilder: (context, index) => Gap(12.w),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilterIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.primaryColor(context)
                            : AppColor.secondAppColor(context),
                        borderRadius: BorderRadius.circular(20.r),
                        border: isSelected
                            ? null
                            : Border.all(color: AppColor.borderColor(context).withOpacity(0.2)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[index],
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: isSelected ? Colors.white : AppColor.darkTextColor(context),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Gap(20.h),

            // Featured Cars Slider
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                width: double.infinity,
                height: 160.h,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (value) => setState(() => _currentBannerIndex = value),
                  itemCount: _featuredCars.length,
                  itemBuilder: (context, index) {
                    final feature = _featuredCars[index];
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.w),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: feature['colors'] as List<Color>,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: (feature['colors'] as List<Color>)[0].withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            right: -20,
                            top: -20,
                            child: Icon(
                              feature['icon'] as IconData,
                              size: 140.sp,
                              color: Colors.white.withOpacity(0.15),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(
                                    feature['badge'] as String,
                                    style: AppTextStyle.bodySmall(context).copyWith(
                                      color: (feature['colors'] as List<Color>)[0],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Gap(12.h),
                                Text(
                                  feature['title'] as String,
                                  style: AppTextStyle.titleMedium(
                                    context,
                                  ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Page Indicators
            Gap(12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _featuredCars.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  height: 6.h,
                  width: _currentBannerIndex == index ? 24.w : 6.w,
                  decoration: BoxDecoration(
                    color: _currentBannerIndex == index
                        ? AppColor.primaryColor(context)
                        : AppColor.greyColor(context).withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),
            Gap(16.h),

            // Cars Listing List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                physics: const BouncingScrollPhysics(),
                itemCount: _cars.length,
                separatorBuilder: (context, index) => Gap(16.h),
                itemBuilder: (context, index) {
                  final car = _cars[index];
                  return _buildPremiumCarCard(car);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumCarCard(Map<String, dynamic> car) {
    return Container(
      height: 140.h,
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Row(
            children: [
              // Image Section
              Container(
                width: 130.w,
                color: Colors.white.withOpacity(0.02),
                child: Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Image.asset(car['image'], fit: BoxFit.contain),
                ),
              ),

              // Details Section
              Expanded(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car['brand'],
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(4.h),
                          Text(
                            car['name'],
                            style: AppTextStyle.titleSmall(context).copyWith(fontSize: 16.sp, color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      // Specs Row (Year, Mileage)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSpecIcon(Icons.calendar_today_outlined, car['year']),
                          _buildSpecIcon(Icons.speed_outlined, car['mileage']),
                        ],
                      ),

                      // Price
                      Text(
                        car['price'],
                        style: AppTextStyle.titleMedium(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Favorite Button
          Positioned(
            top: 8.h,
            left: 8.w, // Assuming RTL
            child: CircleAvatar(
              radius: 14.r,
              backgroundColor: AppColor.scaffoldColor(context).withOpacity(0.7),
              child: Icon(
                car['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                color: car['isFavorite'] ? Colors.redAccent : Colors.white,
                size: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColor.greyColor(context)),
        Gap(4.w),
        Text(label, style: AppTextStyle.bodySmall(context).copyWith(fontSize: 10.sp)),
      ],
    );
  }
}
