import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
          backgroundColor: AppColor.blackTextColor(context).withValues(alpha: 0.4),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.blackTextColor(context),
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
            backgroundColor: AppColor.blackTextColor(context).withValues(alpha: 0.4),
            child: IconButton(
              icon: Icon(Icons.share_outlined, color: AppColor.blackTextColor(context), size: 20),
              onPressed: () {
                if (HiveMethods.getToken() == null) {
                  CommonMethods.showLoginRequiredDialog(context);
                } else {
                  // TODO: Implement Share
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
                backgroundColor: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                child: IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                    color: isFav ? Colors.redAccent : AppColor.blackTextColor(context),
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
        background: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: widget.imagePageController,
              onPageChanged: (index) => setState(() => _currentImageIndex = index),
              itemCount: widget.carImages.length,
              itemBuilder: (context, index) {
                return Hero(
                  tag: index == 0
                      ? 'car_image_${widget.car['name'] ?? ''}'
                      : 'car_image_gallery_$index',
                  child: Container(
                    padding: EdgeInsets.only(top: 80.h, bottom: 40.h),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColor.primaryColor(context).withValues(alpha: 0.15),
                          AppColor.scaffoldColor(context),
                        ],
                      ),
                    ),
                    child: Center(child: Image.asset(widget.carImages[index], fit: BoxFit.contain)),
                  ),
                );
              },
            ),
            // Page Indicator
            Positioned(
              bottom: 20.h,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${_currentImageIndex + 1} / ${widget.carImages.length}',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
