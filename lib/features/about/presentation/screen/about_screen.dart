import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late YoutubePlayerController _controller;
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
    _controller = YoutubePlayerController(
      initialVideoId: 'FtavftvqqWo', // Official company video ID
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: true,
        enableCaption: true,
      ),
    );
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
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _promoController.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: AppColor.primaryColor(context),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(context),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: _buildBioSection(context),
                      ),
                      Gap(24.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: _buildPromoSlider(context),
                      ),
                      Gap(32.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 600),
                        child: _buildVideoSection(context, player),
                      ),
                      Gap(32.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 600),
                        child: _buildBrandsSection(context),
                      ),
                      Gap(32.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 600),
                        child: _buildFinancingSection(context),
                      ),
                      Gap(50.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 380.h,
      pinned: true,
      backgroundColor: AppColor.secondAppColor(context),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22.sp),
      ),
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.only(bottom: 16.h),
        title: Text(
          AppLocaleKey.aboutCompany.tr(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset('assets/images/profile.jpeg', fit: BoxFit.cover, height: 180.h),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.black.withOpacity(0.3), Colors.black.withOpacity(0.7)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBioSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(12.w),
            Text(
              AppLocaleKey.carApp.tr(),
              style: AppTextStyle.titleLarge(
                context,
              ).copyWith(fontWeight: FontWeight.bold, fontSize: 22.sp),
            ),
          ],
        ),
        Gap(16.h),
        Text(
          AppLocaleKey.companyBio.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context).withOpacity(0.7),
            fontSize: 15.sp,
            height: 1.8,
          ),
        ),
      ],
    );
  }

  Widget _buildPromoSlider(BuildContext context) {
    return Container(
      height: 140.h,
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
                      color: AppColor.blackTextColor(context).withOpacity(0.9),
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
                        : AppColor.primaryColor(context).withOpacity(0.2),
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

  Widget _buildVideoSection(BuildContext context, Widget player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.companyVideoTitle.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        Gap(16.h),
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: player,
        ),
      ],
    );
  }

  Widget _buildBrandsSection(BuildContext context) {
    final brands = ['Toyota', 'Ford', 'Nissan', 'Hyundai', 'Lincoln', 'Chery', 'BAIC', 'MG'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.authorizedDistributor.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp),
        ),
        Gap(16.h),
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: brands.map((brand) => _buildBrandChip(context, brand)).toList(),
        ),
      ],
    );
  }

  Widget _buildBrandChip(BuildContext context, String brand) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
      ),
      child: Text(
        brand,
        style: TextStyle(
          color: AppColor.blackTextColor(context),
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  Widget _buildFinancingSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor(context).withOpacity(0.1),
            AppColor.primaryColor(context).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.primaryColor(context).withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Icon(Icons.account_balance_rounded, color: AppColor.primaryColor(context), size: 30.sp),
          Gap(16.w),
          Expanded(
            child: Text(
              AppLocaleKey.financingAvailable.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context).withOpacity(0.9),
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
