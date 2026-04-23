import 'dart:async';

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
      'image':
          'assets/images/car.jpeg', // Fallback as I don't see porsche png yet, but I can use mercedes as placeholder
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
    return SizedBox(
      height: 180.h,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
          // Reset timer when page is changed manually to avoid immediate jump
          _startTimer();
        },
        itemCount: _ads.length * 2000, // Large number for infinite loop
        itemBuilder: (context, index) {
          final adIndex = index % _ads.length;
          final ad = _ads[adIndex];
          return AnimatedBuilder(
            animation: _pageController,
            builder: (context, child) {
              return Transform.scale(scale: index == _currentPage ? 1.0 : 0.95, child: child);
            },
            child: _buildAdCard(ad),
          );
        },
      ),
    );
  }

  Widget _buildAdCard(Map<String, dynamic> ad) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: ad['colors'],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: (ad['colors'][0] as Color).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background accent
          Positioned(
            right: -20.w,
            bottom: -20.h,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.speed_rounded, size: 180.w, color: Colors.white),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(20.w),
            child: Row(
              children: [
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          ad['tag'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 9.sp,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ),
                      Gap(10.h),
                      Text(
                        ad['title'],
                        style: AppTextStyle.titleMedium(
                          context,
                        ).copyWith(color: Colors.white, fontWeight: FontWeight.w900),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4.h),
                      Text(
                        ad['subtitle'],
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(color: Colors.white.withOpacity(0.8)),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ad['colors'][0],
                          elevation: 0,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                          minimumSize: Size(0, 32.h),
                        ),
                        child: Text(
                          'Learn More',
                          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Hero(
                    tag: 'ad_car_${ad['title']}',
                    child: Transform.rotate(
                      angle: -0.05,
                      child: Image.asset(ad['image'], fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
