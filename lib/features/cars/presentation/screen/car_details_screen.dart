import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/car_header_widget.dart';
import 'package:car/features/cars/presentation/widget/features_grid_widget.dart';
import 'package:car/features/cars/presentation/widget/inspection_badge_widget.dart';
import 'package:car/features/cars/presentation/widget/inspection_report_widget.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:car/features/cars/presentation/widget/sliver_app_bar_widget.dart';
import 'package:car/features/cars/presentation/widget/spec_grid_widget.dart';
import 'package:car/features/cars/presentation/widget/sticky_action_bar_widget.dart';
import 'package:car/features/cars/presentation/widget/video_review_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CarDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> car;

  const CarDetailsScreen({super.key, required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> {
  late YoutubePlayerController _controller;
  final PageController _imagePageController = PageController();
  final int _currentImageIndex = 0;

  late List<String> _carImages;

  @override
  void initState() {
    super.initState();
    _carImages = [
      widget.car['image'],
      widget.car['image'],
      widget.car['image'],
    ];

    _controller = YoutubePlayerController(
      initialVideoId: widget.car['video_id'] ?? 'D7O8J5vVf-M',
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
    _imagePageController.dispose();
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
          body: Stack(
            children: [
              CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBarWidget(
                    car: widget.car,
                    imagePageController: _imagePageController,
                    currentImageIndex: _currentImageIndex,
                    carImages: _carImages,
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 140.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CarHeaderWidget(car: widget.car),
                          Gap(24.h),
                          const InspectionBadgeWidget(),
                          Gap(32.h),
                          SpecGridWidget(car: widget.car),
                          Gap(32.h),
                          const InspectionReportWidget(),
                          Gap(32.h),
                          _buildOverview(context),
                          Gap(32.h),
                          const FeaturesGridWidget(),
                          Gap(32.h),
                          VideoReviewWidget(
                            car: widget.car,
                            controller: _controller,
                            player: player,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              StickyActionBarWidget(car: widget.car),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOverview(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitleWidget(title: AppLocaleKey.generalView.tr()),
        Gap(12.h),
        Text(
          AppLocaleKey.specialView.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
            height: 1.7,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
