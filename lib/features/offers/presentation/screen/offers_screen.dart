import 'dart:async';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
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

  late PageController _pageController;
  int _currentBannerIndex = 0;
  late Timer _timer;

  final List<Map<String, dynamic>> _megaOffers = [
    {
      'badge': 'عرض الأسبوع',
      'title': 'تصفية نهاية العام وخصومات حتى 30% على السيارات الفارهة',
      'icon': Icons.local_offer,
      'colors': [const Color(0xFF2563EB), const Color(0xFF3B82F6).withOpacity(0.7)], // App Primary Colors
    },
    {
      'badge': 'حرق أسعار',
      'title': 'استرجاع نقدي يصل إلى 50,000 د.إ على سيارات الدفع الرباعي',
      'icon': Icons.payments_rounded,
      'colors': [const Color(0xFFDC2626), const Color(0xFFEF4444).withOpacity(0.7)], // Red theme
    },
    {
      'badge': 'حصرياً للمشتركين',
      'title': 'صيانة مجانية لمدة 3 سنوات عند شراء أي سيارة رياضية',
      'icon': Icons.handyman_rounded,
      'colors': [const Color(0xFF059669), const Color(0xFF10B981).withOpacity(0.7)], // Green theme
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentBannerIndex);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentBannerIndex < _megaOffers.length - 1) {
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

  // Dummy offers data
  final List<Map<String, dynamic>> _offers = [
    {
      'title': 'عرض خاص على G-Class G63',
      'category': 'فاخرة',
      'discount': '10%',
      'oldPrice': '850K د.إ',
      'newPrice': '765K د.إ',
      'expiresIn': 'ينتهي غداً',
      'image': 'assets/images/cars/mercedes-benz.png',
    },
    {
      'title': 'استرجاع نقدي لـ 911 Turbo S',
      'category': 'رياضية',
      'discount': '15%',
      'oldPrice': '920K د.إ',
      'newPrice': '782K د.إ',
      'expiresIn': 'باقي 5 أيام',
      'image': 'assets/images/cars/porsche.png',
    },
    {
      'title': 'تصفية على M8 Competition',
      'category': 'رياضية',
      'discount': '20%',
      'oldPrice': '650K د.إ',
      'newPrice': '520K د.إ',
      'expiresIn': 'ينتهي قريباً',
      'image': 'assets/images/cars/bmw.png',
    },
    {
      'title': 'خصم نهاية العام RS Q8',
      'category': 'SUV',
      'discount': '25%',
      'oldPrice': '580K د.إ',
      'newPrice': '435K د.إ',
      'expiresIn': 'باقي يومين',
      'image': 'assets/images/cars/audi.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
                child: CustomFormField(
                  radius: 16.r,
                  onChanged: (val) {},
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'ابحث عن العروض والخصومات...',
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

              // Hero Banner (Featured Mega Sale Slider)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 160.h,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (value) => setState(() => _currentBannerIndex = value),
                    itemCount: _megaOffers.length,
                    itemBuilder: (context, index) {
                      final offer = _megaOffers[index];
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 4.w), // slight margin between pages
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: offer['colors'] as List<Color>,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: (offer['colors'] as List<Color>)[0].withOpacity(0.4),
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
                                offer['icon'] as IconData,
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
                                      offer['badge'] as String,
                                      style: AppTextStyle.bodySmall(context).copyWith(
                                        color: (offer['colors'] as List<Color>)[0],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Gap(12.h),
                                  Text(
                                    offer['title'] as String,
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
                  _megaOffers.length,
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
              Gap(24.h),

              // Section Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  'أحدث العروض',
                  style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Gap(16.h),

              // Offers List
              ListView.separated(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 24.h),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _offers.length,
                separatorBuilder: (context, index) => Gap(16.h),
                itemBuilder: (context, index) {
                  return _buildOfferCard(_offers[index]);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOfferCard(Map<String, dynamic> offer) {
    return Container(
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
      child: Row(
        children: [
          // Image / Discount Badge Section
          Container(
            width: 120.w,
            height: 120.h,
            color: Colors.white.withOpacity(0.02),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Image.asset(
                    offer['image'],
                    fit: BoxFit.contain,
                  ), // Removed white tint since these are actual car images not icons
                ),
                Positioned(
                  top: 0,
                  left:
                      0, // Using left to put badge in top-left corner (RTL aware layout might flip this visually)
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(16.r)),
                    ),
                    child: Text(
                      offer['discount'],
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Details Section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    offer['category'],
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.w600),
                  ),
                  Gap(4.h),
                  Text(
                    offer['title'],
                    style: AppTextStyle.text14MPrimary(context).copyWith(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(12.h),

                  // Pricing Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            offer['oldPrice'],
                            style: AppTextStyle.bodySmall(context).copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: AppColor.greyColor(context),
                              fontSize: 10.sp,
                            ),
                          ),
                          Text(
                            offer['newPrice'],
                            style: AppTextStyle.titleSmall(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),

                      // Expiry
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.greyColor(context).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.timer_outlined,
                              size: 12.sp,
                              color: AppColor.greyColor(context),
                            ),
                            Gap(4.w),
                            Text(
                              offer['expiresIn'],
                              style: AppTextStyle.bodySmall(context).copyWith(fontSize: 9.sp),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
