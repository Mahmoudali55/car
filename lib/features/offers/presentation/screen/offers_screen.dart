import 'dart:async';

import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  final List<Map<String, dynamic>> _offers = [
    {
      'title': 'عرض خاص على G-Class G63',
      'name': 'G-Class G63',
      'brand': 'Mercedes-Benz',
      'category': 'فاخرة',
      'discount': '10%',
      'oldPrice': '850,000 د.إ',
      'price': '765,000 د.إ',
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
      'oldPrice': '520,000 د.إ',
      'price': '442,000 د.إ',
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
      'oldPrice': '350,000 د.إ',
      'price': '332,500 د.إ',
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
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Header
          SliverToBoxAdapter(child: _buildHeader()),

          // Featured Slider
          const SliverToBoxAdapter(child: OffersFeaturedSlider()),

          // Filter Section
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFilterChips(),
                  Gap(24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'عروض حصرية لك',
                          style: AppTextStyle.titleMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          '${_offers.length} عروض',
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(color: AppColor.primaryColor(context)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Offers Grid/List
          SliverPadding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: _buildPremiumOfferCard(_offers[index]),
                ),
                childCount: _offers.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
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
                    'مركز العروض',
                    style: AppTextStyle.titleLarge(
                      context,
                    ).copyWith(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 30.sp),
                  ),
                  Text(
                    'أفضل الفرص بانتظارك اليوم',
                    style: AppTextStyle.bodySmall(context).copyWith(color: Colors.white38),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.auto_awesome, color: AppColor.primaryColor(context), size: 24.sp),
              ),
            ],
          ),
          Gap(20.h),
          CustomFormField(
            hintText: 'ابحث في العروض الحالية...',
            prefixIcon: const Icon(Icons.search_rounded, color: Colors.white24),
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
        separatorBuilder: (context, index) => Gap(12.w),
        itemBuilder: (context, index) {
          bool isSelected = _selectedFilterIndex == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilterIndex = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColor.primaryColor(context)
                    : AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Text(
                _filters[index],
                style: AppTextStyle.bodyMedium(context).copyWith(
                  color: isSelected ? Colors.white : Colors.white54,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPremiumOfferCard(Map<String, dynamic> offer) {
    return GestureDetector(
      onTap: () =>
          NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: offer),
      child: Container(
        height: 190.h, // Slightly increased for specs
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Brand Name - Subtle
            Positioned(
              left: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.02,
                child: Text(
                  offer['brand'] ?? '',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            Row(
              children: [
                // Car Image with Gradient Background
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white.withValues(alpha: 0.05), Colors.transparent],
                      ),
                    ),
                    padding: EdgeInsets.all(12.w),
                    child: Hero(
                      tag: 'car_offer_${offer['name']}',
                      child: Image.asset(offer['image'], fit: BoxFit.contain),
                    ),
                  ),
                ),

                // Details
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20.h, 20.w, 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                offer['category'],
                                style: TextStyle(
                                  color: AppColor.primaryColor(context),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, state) {
                                final isFav = context.read<FavoritesCubit>().isFavorite(
                                  offer['name'],
                                );
                                return GestureDetector(
                                  onTap: () => context.read<FavoritesCubit>().toggleFavorite(offer),
                                  child: Icon(
                                    isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                                    color: isFav ? Colors.redAccent : Colors.white24,
                                    size: 22.sp,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Gap(8.h),
                        Text(
                          offer['brand'] ?? '',
                          style: TextStyle(
                            color: AppColor.primaryColor(context),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          offer['name'],
                          style: AppTextStyle.titleMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 17.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(4.h),
                        Row(
                          children: [
                            Icon(Icons.timer_outlined, color: Colors.orangeAccent, size: 12.sp),
                            Gap(4.w),
                            Text(
                              offer['expiresIn'],
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Specs Row
                        Row(
                          children: [
                            _buildMiniSpec(Icons.calendar_today_rounded, offer['year'] ?? '2024'),
                            Gap(12.w),
                            _buildMiniSpec(
                              Icons.settings_input_component_rounded,
                              offer['engine'] ?? 'V8',
                            ),
                          ],
                        ),
                        Gap(12.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  offer['oldPrice'],
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11.sp,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                Text(
                                  offer['price'],
                                  style: AppTextStyle.titleMedium(context).copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 19.sp,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context),
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                                size: 16.sp,
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

            // Discount Badge - Hanging Tag Design
            Positioned(
              left: 20.w,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      offer['discount'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'OFF',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 8.sp,
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

  Widget _buildMiniSpec(IconData icon, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.white24, size: 13.sp),
        Gap(4.w),
        Text(
          value,
          style: TextStyle(color: Colors.white38, fontSize: 10.sp, fontWeight: FontWeight.w500),
        ),
      ],
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
  Timer? _timer;

  final List<Map<String, dynamic>> _featuredOffers = [
    {
      'title': 'موسم القوة!',
      'subtitle': 'وفر حتى 50,000 د.إ على موديلات مرسيدس',
      'color1': const Color(0xff1E293B),
      'color2': const Color(0xff0F172A),
      'icon': Icons.speed_rounded,
    },
    {
      'title': 'عروض تمويل 0%',
      'subtitle': 'ابدأ رحلتك مع تسلا بأقل قسط شهري',
      'color1': const Color(0xff7C3AED),
      'color2': const Color(0xff4C1D95),
      'icon': Icons.electric_car_rounded,
    },
    {
      'title': 'ضمان ممتد مجاناً',
      'subtitle': 'احصل على 5 سنوات ضمان عند شراء أي سيارة SUV',
      'color1': const Color(0xff059669),
      'color2': const Color(0xff064E3B),
      'icon': Icons.verified_user_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentIndex < _featuredOffers.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutQuart,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemCount: _featuredOffers.length,
            itemBuilder: (context, index) {
              final item = _featuredOffers[index];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [item['color1'], item['color2']],
                  ),
                  borderRadius: BorderRadius.circular(32.r),
                  boxShadow: [
                    BoxShadow(
                      color: item['color2'].withValues(alpha: 0.5),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -20,
                      bottom: -20,
                      child: Icon(
                        item['icon'],
                        size: 180.sp,
                        color: Colors.white.withValues(alpha: 0.05),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(28.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              'عرض محدود',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(12.h),
                          Text(
                            item['title'],
                            style: AppTextStyle.titleLarge(context).copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              fontSize: 24.sp,
                            ),
                          ),
                          Gap(8.h),
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              item['subtitle'],
                              style: AppTextStyle.bodyMedium(
                                context,
                              ).copyWith(color: Colors.white70, fontSize: 13.sp),
                            ),
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
        Gap(16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _featuredOffers.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.only(right: 6.w),
              height: 6.h,
              width: _currentIndex == index ? 24.w : 6.w,
              decoration: BoxDecoration(
                color: _currentIndex == index ? AppColor.primaryColor(context) : Colors.white10,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
