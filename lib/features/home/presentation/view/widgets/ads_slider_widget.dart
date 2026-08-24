import 'dart:async';

import 'package:car/features/home/data/model/ad_item_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/screen/main_layout.dart';
import 'package:car/features/home/presentation/view/widgets/ad_card_widget.dart';
import 'package:car/features/home/presentation/view/widgets/ads_dot_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  @override
  void initState() {
    super.initState();

    _currentPage = 1000;

    // Initialize PageController
    _pageController = PageController(initialPage: _currentPage);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final cubit = context.read<HomeCubit>();

      if (cubit.state.financingAdsStatus.isInitial) {
        cubit.getFinancingAds();
      }
    });

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

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

  void _onDotTapped(int i, int totalCount) {
    if (totalCount == 0) return;

    final realIndex = _currentPage % totalCount;
    final target = (_currentPage - realIndex) + i;

    if (_pageController.hasClients) {
      _pageController.animateToPage(
        target,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onAdTap(AdItem ad) {
    if (ad.programId != null) {
      context.read<HomeCubit>().getFinancingAds(code: ad.programId.toString());
    } else {
      context.read<HomeCubit>().getFinancingAds();
    }

    MainLayout.tabIndex.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => previous.financingAdsStatus != current.financingAdsStatus,
      builder: (context, state) {
        if (!state.financingAdsStatus.isSuccess) {
          return const SizedBox.shrink();
        }

        final models = state.financingAdsStatus.data;

        if (models == null || models.isEmpty) {
          return const SizedBox.shrink();
        }

        final List<AdItem> adsList = List.generate(
          models.length,
          (index) => AdItem.fromFinancingAd(models[index], index),
        );

        final realIndex = _currentPage % adsList.length;

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 195.h,
              child: PageView.builder(
                controller: _pageController,
                itemCount: adsList.length * 2000,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });

                  _startTimer();
                },
                itemBuilder: (context, index) {
                  final ad = adsList[index % adsList.length];

                  return AnimatedScale(
                    scale: index == _currentPage ? 1.0 : 0.95,
                    duration: const Duration(milliseconds: 350),
                    curve: Curves.easeOutCubic,
                    child: AdCardWidget(ad: ad, onTap: () => _onAdTap(ad)),
                  );
                },
              ),
            ),

            Gap(10.h),

            AdsDotIndicator(
              count: adsList.length,
              currentIndex: realIndex,
              activeColor: adsList[realIndex].accentColor,
              onDotTapped: (i) => _onDotTapped(i, adsList.length),
            ),
          ],
        );
      },
    );
  }
}
