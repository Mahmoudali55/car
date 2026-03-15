import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'فاخرة', 'رياضية', 'SUV', 'سيدان'];

  // Dummy offers data
  final List<Map<String, dynamic>> _offers = [
    {
      'title': 'عرض خاص على G-Class G63',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'category': 'فاخرة',
      'discount': '10%',
      'oldPrice': '850K د.إ',
      'price': '765K د.إ',
      'expiresIn': 'ينتهي غداً',
      'image': 'assets/images/cars/mercedes-benz.png',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '4.0L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': true,
    },
    {
      'title': 'خصم حصري BMW M5',
      'name': 'M5 Competition',
      'brand': 'BMW',
      'category': 'رياضية',
      'discount': '15%',
      'oldPrice': '520K د.إ',
      'price': '442K د.إ',
      'expiresIn': '3 أيام',
      'image': 'assets/images/cars/bmw.png',
      'year': '2023',
      'mileage': '5,000 كم',
      'engine': '4.4L V8',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
    {
      'title': 'تمويل مرن Land Cruiser',
      'name': 'Land Cruiser 300',
      'brand': 'Toyota',
      'category': 'SUV',
      'discount': '5%',
      'oldPrice': '350K د.إ',
      'price': '332K د.إ',
      'expiresIn': '5 أيام',
      'image': 'assets/images/cars/toyota.png',
      'year': '2024',
      'mileage': '0 كم',
      'engine': '3.5L V6',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with Search
        _buildHeader(),

        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            children: [
              // Animated Offers Slider (Featured)
              const OffersFeaturedSlider(),
              Gap(24.h),

              // Filter Chips
              _buildFilterChips(),
              Gap(24.h),

              // Offers List
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'أفضل العروض المتاحة',
                  style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Gap(16.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
                itemCount: _offers.length,
                separatorBuilder: (context, index) => Gap(16.h),
                itemBuilder: (context, index) {
                  return _buildOfferCard(_offers[index]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'عروض جبارة',
            style: AppTextStyle.titleLarge(context).copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 28.sp,
            ),
          ),
          Gap(4.h),
          Text(
            'استمتع بأفضل الأسعار والخصومات الحصرية',
            style: AppTextStyle.bodySmall(context).copyWith(color: Colors.white60),
          ),
          Gap(20.h),
          Row(
            children: [
              Expanded(
                child: CustomFormField(
                  hintText: 'ابحث عن عرض محدد...',
                  prefixIcon: const Icon(Icons.search_rounded),
                ),
              ),
              Gap(12.w),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: AppColor.secondAppColor(context),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: const Icon(Icons.sort_rounded, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 40.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        itemCount: _filters.length,
        separatorBuilder: (context, index) => Gap(8.w),
        itemBuilder: (context, index) {
          bool isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilterIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.primaryColor(context) : Colors.transparent,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.white.withOpacity(0.1),
                ),
              ),
              child: Text(
                _filters[index],
                style: AppTextStyle.bodyMedium(context).copyWith(
                  color: isSelected ? Colors.white : Colors.white60,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: offer);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    width: 100.w,
                    height: 100.h,
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Hero(
                      tag: 'car_image_${offer['name']}',
                      child: Image.asset(offer['image'], fit: BoxFit.contain),
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: AppColor.primaryColor(context).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            offer['category'],
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Gap(8.h),
                        Text(
                          offer['title'],
                          style: AppTextStyle.bodyMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(8.h),
                        Row(
                          children: [
                            Text(
                              offer['price'],
                              style: AppTextStyle.titleMedium(context).copyWith(
                                color: AppColor.primaryColor(context),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Gap(8.w),
                            Text(
                              offer['oldPrice'],
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: Colors.white38,
                                decoration: TextDecoration.lineThrough,
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
            Positioned(
              top: 0,
              left: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
                ),
                child: Column(
                  children: [
                    Text(
                      'خصم',
                      style: AppTextStyle.bodySmall(context).copyWith(color: Colors.white, fontSize: 8.sp),
                    ),
                    Text(
                      offer['discount'],
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OffersFeaturedSlider extends StatefulWidget {
  const OffersFeaturedSlider({super.key});

  @override
  State<OffersFeaturedSlider> createState() => _OffersFeaturedSliderState();
}

class _OffersFeaturedSliderState extends State<OffersFeaturedSlider> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 160.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.primaryColor(context), const Color(0xff0044BB)],
                  ),
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -30,
                      bottom: -20,
                      child: Opacity(
                        opacity: 0.2,
                        child: Icon(Icons.local_offer, size: 150.sp, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(24.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'تخفيضات الربيع!',
                            style: AppTextStyle.titleLarge(context).copyWith(color: Colors.white),
                          ),
                          Gap(8.h),
                          Text(
                            'وفر حتى 20% على موديلات 2024 المختارة',
                            style: AppTextStyle.bodyMedium(context).copyWith(color: Colors.white70),
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
        Gap(12.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            3,
            (index) => Container(
              margin: EdgeInsets.only(right: 6.w),
              height: 6.h,
              width: _currentIndex == index ? 24.w : 6.w,
              decoration: BoxDecoration(
                color: _currentIndex == index ? AppColor.primaryColor(context) : Colors.white24,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
