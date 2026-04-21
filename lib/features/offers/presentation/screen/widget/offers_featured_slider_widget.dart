import 'dart:async';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
      'subtitle': 'وفر حتى 50,000  ر.س        على موديلات مرسيدس',
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
                      color: item['color2'].withOpacity(0.5),
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
                        color: AppColor.whiteColor(context).withOpacity(0.05),
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
                              color: AppColor.whiteColor(context).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Text(
                              AppLocaleKey.limited.tr(),
                              style: TextStyle(
                                color: AppColor.whiteColor(context),
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Gap(12.h),
                          Text(
                            item['title'],
                            style: AppTextStyle.titleLarge(context).copyWith(
                              color: AppColor.whiteColor(context),
                              fontWeight: FontWeight.w900,
                              fontSize: 24.sp,
                            ),
                          ),
                          Gap(8.h),
                          SizedBox(
                            width: 200.w,
                            child: Text(
                              item['subtitle'],
                              style: AppTextStyle.bodyMedium(context).copyWith(
                                color: AppColor.whiteColor(context).withOpacity(0.70),
                                fontSize: 13.sp,
                              ),
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
                color: _currentIndex == index
                    ? AppColor.primaryColor(context)
                    : AppColor.blackTextColor(context).withOpacity(0.10),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
