import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:animate_do/animate_do.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
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

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
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
      expandedHeight: 200.h,
      pinned: true,
      backgroundColor: AppColor.secondAppColor(context),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 22.sp),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          AppLocaleKey.aboutCompany.tr(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/profile.jpeg',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.7),
                  ],
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
              style: AppTextStyle.titleLarge(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
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

  Widget _buildVideoSection(BuildContext context, Widget player) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.companyVideoTitle.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
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
    final brands = [
      'Toyota', 'Ford', 'Nissan', 'Hyundai', 'Lincoln',
      'Chery', 'BAIC', 'MG'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.authorizedDistributor.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
          ),
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
