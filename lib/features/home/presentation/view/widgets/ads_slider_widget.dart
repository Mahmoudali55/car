import 'dart:async';

import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdsSliderWidget extends StatefulWidget {
  const AdsSliderWidget({super.key});

  @override
  State<AdsSliderWidget> createState() => _AdsSliderWidgetState();
}

class _AdsSliderWidgetState extends State<AdsSliderWidget> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> _ads = [
    {
      'title': 'New G63 AMG 2024',
      'subtitle': 'The Ultimate Off-Road Icon',
      'image': 'assets/images/car.jpeg',
      'colors': [const Color(0xFF1A1A1A), const Color(0xFF434343)],
      'tag': 'SPECIAL OFFER',
    },
    {
      'title': 'BMW M5 Competition',
      'subtitle': 'Pure Performance Unleashed',
      'image': 'assets/images/car.jpeg',
      'colors': [const Color(0xFF003366), const Color(0xFF0055A4)],
      'tag': 'FEATURED',
    },
    {
      'title': 'Porsche 911 GT3 RS',
      'subtitle': 'Born for the Racetrack',
      'image': 'assets/images/car.jpeg',
      'colors': [const Color(0xFF8B0000), const Color(0xFFB22222)],
      'tag': 'LIMITED TIME',
    },
  ];

  @override
  void initState() {
    super.initState();
    _currentPage = _ads.length * 1000;
    _pageController = PageController(initialPage: _currentPage);
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      _currentPage++;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
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
    return SizedBox(
      height: 190.h,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          _startTimer();
        },
        itemCount: _ads.length * 2000,
        itemBuilder: (context, index) {
          final adIndex = index % _ads.length;
          final ad = _ads[adIndex];

          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              final isActive = index == _currentPage;
              return Transform.scale(scale: isActive ? 1.0 : 0.94, child: child);
            },
            child: _buildAdCard(ad),
          );
        },
      ),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28.r),
        gradient: LinearGradient(
          colors: ad['colors'],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: (ad['colors'][0] as Color).withOpacity(0.35),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Stack(
          children: [
            /// Overlay يعطي عمق
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColor.blackColor(context).withOpacity(0.25), Colors.transparent],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(18.w),
              child: Row(
                children: [
                  /// النصوص
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TAG
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: Text(
                            ad['tag'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),

                        Gap(12.h),

                        /// TITLE
                        Text(
                          ad['title'],
                          style: AppTextStyle.titleMedium(context).copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 18.sp,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        Gap(6.h),

                        /// SUBTITLE
                        Text(
                          ad['subtitle'],
                          style: AppTextStyle.bodySmall(
                            context,
                          ).copyWith(color: Colors.white.withOpacity(0.85), fontSize: 12.sp),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),

                        const Spacer(),

                        /// BUTTON
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColor.blackColor(context).withOpacity(0.2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Explore',
                                  style: TextStyle(
                                    color: ad['colors'][0],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                Gap(6.w),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 14.w,
                                  color: ad['colors'][0],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Gap(10.w),

                  /// الصورة
                  Expanded(
                    flex: 5,
                    child: TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 600),
                      tween: Tween<double>(begin: 0.9, end: 1),
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 20),
                            child: child,
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'ad_car_${ad['title']}',
                        child: ad['image'].toString().startsWith('http')
                            ? CustomNetworkImage(imageUrl: ad['image'], fit: BoxFit.contain)
                            : Image.asset(ad['image'], fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
