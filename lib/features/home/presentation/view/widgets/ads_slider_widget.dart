// ─── ads_slider_widget.dart ──────────────────────────────────────

import 'dart:async';

import 'package:car/features/home/data/model/ad_item_model.dart';
import 'package:car/features/home/presentation/view/widgets/ads_dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'ad_card_widget.dart';

class AdsSliderWidget extends StatefulWidget {
  const AdsSliderWidget({super.key});

  @override
  State<AdsSliderWidget> createState() => _AdsSliderWidgetState();
}

class _AdsSliderWidgetState extends State<AdsSliderWidget> {
  late final PageController _pageController;
  int _currentPage = 0;
  Timer? _timer;

  static const List<AdItem> _ads = [
    AdItem(
      title: 'New G63 AMG 2024',
      subtitle: 'The Ultimate Off-Road Icon',
      tag: 'SPECIAL OFFER',
      price: '\$185,000',
      image: 'assets/images/g63.png',
      accentColor: Color(0xFFFFD700),
      bgColors: [Color(0xFF1A1A1A), Color(0xFF3A3A3A)],
    ),
    AdItem(
      title: 'BMW M5 Competition',
      subtitle: 'Pure Performance Unleashed',
      tag: 'FEATURED',
      price: '\$145,000',
      image: 'assets/images/bmw_m5.png',
      accentColor: Color(0xFF4FC3F7),
      bgColors: [Color(0xFF0D1B2A), Color(0xFF1A3550)],
    ),
    AdItem(
      title: 'Porsche 911 GT3 RS',
      subtitle: 'Born for the Racetrack',
      tag: 'LIMITED TIME',
      price: '\$230,000',
      image: 'assets/images/porsche.png',
      accentColor: Color(0xFFFF6B6B),
      bgColors: [Color(0xFF1A0A0A), Color(0xFF3A1515)],
    ),
  ];

  // ─── Lifecycle ───────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _currentPage = _ads.length * 1000;
    _pageController = PageController(initialPage: _currentPage);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ─── Timer ───────────────────────────────────────────────────

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (!mounted) return;
      _currentPage++;
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  void _onDotTapped(int i) {
    final realIndex = _currentPage % _ads.length;
    final target = (_currentPage - realIndex) + i;
    _pageController.animateToPage(
      target,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  // ─── Build ───────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final realIndex = _currentPage % _ads.length;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 195.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _ads.length * 2000,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
              _startTimer();
            },
            itemBuilder: (context, index) {
              final ad = _ads[index % _ads.length];
              return AnimatedScale(
                scale: index == _currentPage ? 1.0 : 0.95,
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                child: AdCardWidget(ad: ad),
              );
            },
          ),
        ),
        Gap(10.h),
        AdsDotIndicator(
          count: _ads.length,
          currentIndex: realIndex,
          activeColor: _ads[realIndex].accentColor,
          onDotTapped: _onDotTapped,
        ),
      ],
    );
  }
}
