import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/common_methods.dart';
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
  });
  final Map<String, dynamic> car;
  final PageController imagePageController;
  final int currentImageIndex;
  final List<String> carImages;
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
      expandedHeight: 380.h,
      pinned: true,
      elevation: 0,
      stretch: true,
      backgroundColor: AppColor.scaffoldColor(context),
      leading: Padding(
        padding: EdgeInsets.all(8.w),
        child: CircleAvatar(
          backgroundColor: AppColor.whiteColor(context),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black, size: 20),
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
              icon: const Icon(Icons.share_outlined, color: Colors.black, size: 20),
              onPressed: () {
                if (HiveMethods.getToken() == null) {
                  CommonMethods.showLoginRequiredDialog(context);
                } else {
                  final String carName = widget.car['name'] ?? '';
                  final String carPrice = widget.car['price'] ?? '';
                  final String message =
                      '${AppLocaleKey.checkOutThisCar.tr()} $carName ${AppLocaleKey.atPrice.tr()} $carPrice\n\n${AppLocaleKey.downloadApp.tr()}: https://hbwinternational.com';
                  Share.share(message);
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
                    color: isFav ? Colors.redAccent : Colors.black,
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

            return Stack(
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
                          ? 'car_image_${widget.car['itemCode'] ?? widget.car['name']}'
                          : 'car_image_gallery_${widget.car['itemCode'] ?? widget.car['name']}_$index',
                      child: Container(
                        decoration: BoxDecoration(color: AppColor.scaffoldColor(context)),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Blurred Background Accent
                            if (isNetwork)
                              Opacity(
                                opacity: 0.1,
                                child: Image.network(imageUrl, fit: BoxFit.cover),
                              ),

                            // Car Image with better spacing
                            Padding(
                              padding: EdgeInsets.fromLTRB(20.w, 80.h, 20.w, 60.h),
                              child: isNetwork
                                  ? Image.network(
                                      imageUrl,
                                      fit: BoxFit.contain,
                                      errorBuilder: (_, __, ___) => Icon(
                                        Icons.directions_car_rounded,
                                        size: 120.h,
                                        color: AppColor.greyColor(context).withOpacity(0.5),
                                      ),
                                    )
                                  : Image.asset(
                                      imageUrl.isEmpty ? 'assets/images/placeholder.png' : imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                            ),

                            // Bottom Fade Overlay
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              height: 100.h,
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      AppColor.scaffoldColor(context),
                                      AppColor.scaffoldColor(context).withOpacity(0),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Premium Page Indicator (Pill Design)
                if (displayedImages.length > 1)
                  Positioned(
                    bottom: 30.h,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(30.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.photo_library_outlined, color: Colors.white, size: 14.sp),
                            Gap(8.w),
                            Text(
                              '${safeIndex + 1} / ${displayedImages.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
