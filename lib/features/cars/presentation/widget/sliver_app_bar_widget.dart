import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/cars/presentation/widget/full_image_gallery_screen.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:share_plus/share_plus.dart';

class SliverAppBarWidget extends StatefulWidget {
  const SliverAppBarWidget({
    super.key,
    required this.car,
    required this.imagePageController,
    required this.currentImageIndex,
    required this.carImages,
    this.heroTag,
  });
  final Map<String, dynamic> car;
  final PageController imagePageController;
  final int currentImageIndex;
  final List<String> carImages;
  final String? heroTag;
  @override
  State<SliverAppBarWidget> createState() => _SliverAppBarWidgetState();
}

class _SliverAppBarWidgetState extends State<SliverAppBarWidget> {
  late int _currentImageIndex;

  @override
  void initState() {
    super.initState();
    _currentImageIndex = widget.currentImageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.h,
      pinned: true,
      elevation: 0,
      stretch: true,
      backgroundColor: AppColor.scaffoldColor(context),
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: CircleAvatar(
          backgroundColor: AppColor.whiteColor(context),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.blackColor(context),
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(
            backgroundColor: AppColor.whiteColor(context),
            child: IconButton(
              icon: Icon(Icons.share_outlined, color: AppColor.blackColor(context), size: 20),
              onPressed: () {
                if (HiveMethods.getToken() == null) {
                  CommonMethods.showLoginRequiredDialog(context);
                } else {
                  final String carName = widget.car['name'] ?? '';
                  final String carPrice = widget.car['price'] ?? '';
                  final String message =
                      '${AppLocaleKey.checkOutThisCar.tr()} $carName ${AppLocaleKey.atPrice.tr()} $carPrice\n\n${AppLocaleKey.downloadApp.tr()}: https://hbwinternational.com';
                  SharePlus.instance.share(ShareParams(text: message));
                }
              },
            ),
          ),
        ),
        BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            final isFav = context.read<FavoritesCubit>().isFavorite(widget.car['name'] ?? '');
            return Padding(
              padding: EdgeInsets.all(8.w),
              child: CircleAvatar(
                backgroundColor: AppColor.whiteColor(context),
                child: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: isFav ? AppColor.redColor(context) : AppColor.blackColor(context),
                    size: 20,
                  ),
                  onPressed: () {
                    if (HiveMethods.getToken() == null) {
                      CommonMethods.showLoginRequiredDialog(context);
                    } else {
                      context.read<FavoritesCubit>().toggleFavorite(widget.car);
                    }
                  },
                ),
              ),
            );
          },
        ),
        Gap(12.w),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            List<String> displayedImages = [widget.car['image'] ?? 'assets/images/placeholder.png'];

            if (widget.car['extraImages'] != null &&
                (widget.car['extraImages'] as List).isNotEmpty) {
              final extraImages = widget.car['extraImages'] as List<String>;
              for (var img in extraImages) {
                if (!displayedImages.contains(img)) {
                  displayedImages.add(img);
                }
              }
            }

            final safeIndex = _currentImageIndex < displayedImages.length ? _currentImageIndex : 0;

            return GestureDetector(
              onTap: () {
                // Open full screen gallery
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FullImageGalleryScreen(
                      images: displayedImages,
                      initialIndex: safeIndex,
                      car: widget.car,
                    ),
                  ),
                );
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Main Image Slider
                  PageView.builder(
                    controller: widget.imagePageController,
                    onPageChanged: (index) => setState(() => _currentImageIndex = index),
                    itemCount: displayedImages.length,
                    itemBuilder: (context, index) {
                      final imageUrl = displayedImages[index];
                      final isNetwork = imageUrl.startsWith('http');

                      return Hero(
                        tag: index == 0
                            ? (widget.heroTag ??
                                'car_image_${widget.car['itemCode'] ?? widget.car['name']}')
                            : 'car_image_full_${widget.car['itemCode'] ?? widget.car['name']}_$index',
                        child: Container(
                          height: 100.h,
                          width: 50.w,
                          decoration: BoxDecoration(color: AppColor.scaffoldColor(context)),
                          child: isNetwork
                              ? CustomNetworkImage(imageUrl: imageUrl, fit: BoxFit.cover)
                              : Image.asset(
                                  imageUrl.isEmpty ? 'assets/images/placeholder.png' : imageUrl,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      );
                    },
                  ),

                  // Top Left Counter (e.g. 1 / 38)
                  Positioned(
                    top: 100.h,
                    left: 20.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Text(
                        '${safeIndex + 1} / ${displayedImages.length}',
                        style: TextStyle(
                          color: AppColor.whiteColor(context),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // Click to enlarge overlay
                  Positioned(
                    bottom: 80.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColor.blackTextColor(context).withValues(alpha: (0.2)),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.fullscreen_rounded,
                              color: AppColor.whiteColor(context),
                              size: 18.sp,
                            ),
                            Gap(6.w),
                            Text(
                              AppLocaleKey.agentImageZoom.tr(),
                              style: AppTextStyle.bodySmall(
                                context,
                              ).copyWith(color: AppColor.whiteColor(context)),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Dash Indicators
                  if (displayedImages.length > 1)
                    Positioned(
                      bottom: 50.h,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(displayedImages.length, (index) {
                          final isSelected = index == safeIndex;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: EdgeInsets.symmetric(horizontal: 3.w),
                            height: 4.h,
                            width: isSelected ? 30.w : 15.w,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.primaryColor(context)
                                  : AppColor.blackTextColor(context).withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                          );
                        }),
                      ),
                    ),

                  // Bottom Fade Overlay
                  Positioned(
                    bottom: -1,
                    left: 0,
                    right: 0,
                    height: 40.h,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            AppColor.scaffoldColor(context),
                            AppColor.scaffoldColor(context),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
