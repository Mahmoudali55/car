import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../widgets/about_app_bar.dart';
import '../widgets/about_bio_section.dart';
import '../widgets/about_brands_section.dart';
import '../widgets/about_financing_section.dart';
import '../widgets/about_promo_slider.dart';
import '../widgets/about_video_section.dart';

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
              const AboutAppBar(),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FadeInUp(
                        duration: const Duration(milliseconds: 600),
                        child: const AboutBioSection(),
                      ),
                      Gap(24.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 100),
                        child: const AboutPromoSlider(),
                      ),
                      Gap(32.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 600),
                        child: AboutVideoSection(player: player),
                      ),
                      Gap(32.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 600),
                        child: const AboutBrandsSection(),
                      ),
                      Gap(32.h),
                      FadeInUp(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 600),
                        child: const AboutFinancingSection(),
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
}
