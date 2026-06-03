import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/bnpl_widget.dart';
import 'package:car/features/cars/presentation/widget/car_header_widget.dart';
import 'package:car/features/cars/presentation/widget/car_info_tabs_widget.dart';
import 'package:car/features/cars/presentation/widget/cash_packages_widget.dart';
import 'package:car/features/cars/presentation/widget/features_grid_widget.dart';
import 'package:car/features/cars/presentation/widget/section_title_widget.dart';
import 'package:car/features/cars/presentation/widget/sliver_app_bar_widget.dart';
import 'package:car/features/cars/presentation/widget/sticky_action_bar_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CarDetailsScreen extends StatefulWidget {
  final GetBrandCarsDataModel car;
  final String? heroTag;

  const CarDetailsScreen({super.key, required this.car, this.heroTag});

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
    HiveMethods.addToRecentlyViewed(widget.car.toMap());
    final mainImage = widget.car.fullCarImage.isNotEmpty
        ? widget.car.fullCarImage
        : AppImages.assetsImagesPlaceholder;
    _carImages = [mainImage];
    _controller = YoutubePlayerController(
      initialVideoId: widget.car.videoId,
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
        thumbnail: widget.car.fullCarImage.isNotEmpty && widget.car.fullCarImage.startsWith('http')
            ? CustomNetworkImage(imageUrl: widget.car.fullCarImage, fit: BoxFit.cover)
            : Image.asset(
                widget.car.fullCarImage.isNotEmpty
                    ? widget.car.fullCarImage
                    : AppImages.assetsImagesPlaceholder,
                fit: BoxFit.cover,
              ),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          bottomNavigationBar: StickyActionBarWidget(car: widget.car),
          body: SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBarWidget(
                      car: widget.car,
                      imagePageController: _imagePageController,
                      currentImageIndex: _currentImageIndex,
                      carImages: _carImages,
                      heroTag: widget.heroTag,
                    ),
                    SliverToBoxAdapter(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CarHeaderWidget(car: widget.car),
                              if (widget.car.isTamaraAvailable) ...[
                                Gap(16.h),
                                BnplWidget(car: widget.car),
                                // Gap(16.h),
                                CashPackagesWidget(car: widget.car),
                              ],
                              Gap(16.h),
                              CarInfoTabsWidget(car: widget.car),
                              _buildOverview(context),
                              Gap(16.h),
                              FeaturesGridWidget(car: widget.car),

                              Gap(20.h),
                              // VideoReviewWidget(
                              //   car: widget.car,
                              //   controller: _controller,
                              //   player: player,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
          style: TextStyle(color: AppColor.blackTextColor(context), height: 1.7, fontSize: 14.sp),
        ),
      ],
    );
  }
}
