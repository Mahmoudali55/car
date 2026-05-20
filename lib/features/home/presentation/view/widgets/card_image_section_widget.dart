import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/home/presentation/view/widgets/favorite_button_widget.dart';
import 'package:car/features/home/presentation/view/widgets/hot_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardImageSection extends StatelessWidget {
  const CardImageSection({required this.car, required this.isSelected, this.heroTag});

  final Map<String, dynamic> car;
  final bool isSelected;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 400),
            scale: 1,
            child: Hero(
              tag: heroTag ?? 'car_image_${car['itemCode'] ?? car['name']}',
              child: Center(
                child: CustomNetworkImage(
                  imageUrl: car['image']!,
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 200.h,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 5.h,
          right: 16.w,
          child: FavoriteButton(car: car),
        ),
        Positioned(top: 5.h, left: 16.w, child: HotBadge()),
      ],
    );
  }
}
