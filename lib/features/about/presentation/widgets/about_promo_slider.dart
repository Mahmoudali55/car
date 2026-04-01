import 'dart:async';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutPromoSlider extends StatefulWidget {
  const AboutPromoSlider({super.key});

  @override
  State<AboutPromoSlider> createState() => _AboutPromoSliderState();
}

class _AboutPromoSliderState extends State<AboutPromoSlider> {
  late PageController _promoController;
  late Timer _timer;
  int _currentPromoIndex = 0;

  final List<String> _promos = [
    AppLocaleKey.promo1,
    AppLocaleKey.promo2,
    AppLocaleKey.promo3,
    AppLocaleKey.promo4,
    AppLocaleKey.availableBanks,
  ];

  @override
  void initState() {
    super.initState();
    _promoController = PageController();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (_currentPromoIndex < _promos.length - 1) {
        _currentPromoIndex++;
      } else {
        _currentPromoIndex = 0;
      }
      if (_promoController.hasClients) {
        _promoController.animateToPage(
          _currentPromoIndex,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _promoController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140.h,
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          PageView.builder(
            controller: _promoController,
            itemCount: _promos.length,
            onPageChanged: (index) {
              setState(() {
                _currentPromoIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Text(
                    _promos[index].tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColor.whiteColor(context),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                    ),
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: 12.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _promos.length,
                (index) => Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w),
                  width: _currentPromoIndex == index ? 20.w : 6.w,
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: _currentPromoIndex == index
                        ? AppColor.primaryColor(context)
                        : AppColor.primaryColor(context).withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(3.r),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
