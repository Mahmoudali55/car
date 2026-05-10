import 'dart:async';
import 'dart:ui';
import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FeaturedCarsSliderWidget extends StatefulWidget {
  final List<Map<String, String>> featuredCars;
  const FeaturedCarsSliderWidget({super.key, required this.featuredCars});

  @override
  State<FeaturedCarsSliderWidget> createState() => _FeaturedCarsSliderWidgetState();
}

class _FeaturedCarsSliderWidgetState extends State<FeaturedCarsSliderWidget> {
  late final PageController _pageController;
  int _currentSliderIndex = 0;
  Timer? _autoPlayTimer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.9, initialPage: 0);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        if (_currentSliderIndex < widget.featuredCars.length - 1) {
          _currentSliderIndex++;
        } else {
          _currentSliderIndex = 0;
        }
        _pageController.animateToPage(
          _currentSliderIndex,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.featuredCars.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        SizedBox(
          height: 220.h,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentSliderIndex = index);
            },
            itemCount: widget.featuredCars.length,
            itemBuilder: (context, index) {
              final car = widget.featuredCars[index];
              final isSelected = _currentSliderIndex == index;
              
              return AnimatedScale(
                scale: isSelected ? 1.0 : 0.92,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                child: GestureDetector(
                  onTap: () {
                    NavigatorMethods.pushNamed(
                      context,
                      RoutesName.carDetailsScreen,
                      arguments: {
                        'car': car,
                        'heroTag': 'featured_car_image_${car['itemCode'] ?? car['name']}',
                      },
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      color: AppColor.secondAppColor(context),
                      borderRadius: BorderRadius.circular(28.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        // Background Image with Hero
                        Positioned.fill(
                          child: Hero(
                            tag: 'featured_car_image_${car['itemCode'] ?? car['name']}',
                            child: car['image'].toString().trim().startsWith('http')
                                ? CustomNetworkImage(
                                    imageUrl: car['image']!,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    car['image']!,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) => _buildErrorImage(context),
                                  ),
                          ),
                        ),
                        
                        // Gradient Overlay
                        Positioned.fill(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.1),
                                  Colors.black.withOpacity(0.8),
                                ],
                                stops: const [0.0, 0.4, 1.0],
                              ),
                            ),
                          ),
                        ),

                        // Special Offer Tag
                        Positioned(
                          top: 16.h,
                          left: 16.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: AppColor.primaryColor(context),
                              borderRadius: BorderRadius.circular(12.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.primaryColor(context).withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Text(
                              AppLocaleKey.specialOffersCars.tr(),
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: AppColor.whiteColor(context),
                                fontSize: 11.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),

                        // Glassmorphism Content
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  border: Border(
                                    top: BorderSide(
                                      color: Colors.white.withOpacity(0.2),
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            car['name'] ?? '',
                                            style: AppTextStyle.titleLarge(context).copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.sp,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Gap(4.h),
                                          if (car['installments'] != null)
                                            Text(
                                              car['installments']!,
                                              style: AppTextStyle.bodySmall(context).copyWith(
                                                color: Colors.white.withOpacity(0.8),
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          car['price'] ?? '',
                                          style: AppTextStyle.titleMedium(context).copyWith(
                                            color: AppColor.primaryColor(context),
                                            fontWeight: FontWeight.w900,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                        Gap(2.h),
                                        Text(
                                          AppLocaleKey.taxIncluded.tr(),
                                          style: TextStyle(
                                            color: Colors.white.withOpacity(0.6),
                                            fontSize: 9.sp,
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
                ),
              );
            },
          ),
        ),
        Gap(16.h),
        // Smooth Animated Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.featuredCars.length,
            (index) {
              final isCurrent = _currentSliderIndex == index;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                height: 8.h,
                width: isCurrent ? 28.w : 8.w,
                decoration: BoxDecoration(
                  color: isCurrent
                      ? AppColor.primaryColor(context)
                      : AppColor.greyColor(context).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: isCurrent 
                    ? [
                        BoxShadow(
                          color: AppColor.primaryColor(context).withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        )
                      ]
                    : null,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildErrorImage(BuildContext context) {
    return Container(
      color: AppColor.greyColor(context).withOpacity(0.1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              color: AppColor.primaryColor(context).withOpacity(0.5),
              size: 40.sp,
            ),
            Gap(8.h),
            Text(
              'Image Not Available',
              style: TextStyle(
                color: AppColor.greyColor(context).withOpacity(0.5),
                fontSize: 10.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

