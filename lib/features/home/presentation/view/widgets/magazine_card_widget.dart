import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/card_footer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MagazineCardWidget extends StatelessWidget {
  const MagazineCardWidget({super.key, required this.car, this.heroTag});

  final Map<String, dynamic> car;
  final String? heroTag;

  void _navigateToDetails(BuildContext context) {
    NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen,
        arguments: {'car': car, 'heroTag': heroTag});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
        height: 360.h,
        width: double.infinity,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor(context).withValues(alpha: (0.12)),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                _CardImage(car: car, heroTag: heroTag),
                _CardTopBar(car: car),
              ],
            ),
            CardFooter(car: car),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────

class _CardTopBar extends StatelessWidget {
  const _CardTopBar({required this.car});

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _BrandBadge(brand: car['brand']),
          _FavoriteButton(car: car),
        ],
      ),
    );
  }
}

class _BrandBadge extends StatelessWidget {
  const _BrandBadge({required this.brand});

  final String brand;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: (0.12)),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: (0.25))),
      ),
      child: Text(
        brand,
        style: AppTextStyle.bodySmall(context).copyWith(
          color: AppColor.primaryColor(context),
          fontWeight: FontWeight.bold,
          fontSize: 11.sp,
        ),
      ),
    );
  }
}

class _FavoriteButton extends StatelessWidget {
  const _FavoriteButton({required this.car});

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        final isFav = context.read<FavoritesCubit>().isFavorite(car['name']);
        return GestureDetector(
          onTap: () => context.read<FavoritesCubit>().toggleFavorite(car),
          child: CircleAvatar(
            radius: 18.r,
            backgroundColor: AppColor.blackColor(context).withValues(alpha: (0.1)),
            child: Icon(
              isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
              color: isFav ? AppColor.redColor(context) : AppColor.blackTextColor(context),
              size: 20.sp,
            ),
          ),
        );
      },
    );
  }
}

class _CardImage extends StatelessWidget {
  const _CardImage({required this.car, this.heroTag});

  final Map<String, dynamic> car;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    final imageUrl = car['image'].toString();
    final actualHeroTag = heroTag ?? 'car_image_${car['itemCode'] ?? car['name']}';

    return SizedBox(
      height: 200.h,
      width: double.infinity,
      child: Hero(
        tag: actualHeroTag,
        child: imageUrl.startsWith('http')
            ? CustomNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 200.h,
              )
            : Image.asset(
                imageUrl.isNotEmpty ? imageUrl : 'assets/images/placeholder.png',
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
