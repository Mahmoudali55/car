// ─── ad_card_image.dart ──────────────────────────────────────────

import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/features/home/data/model/ad_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdCardImage extends StatelessWidget {
  final AdItem ad;

  const AdCardImage({super.key, required this.ad});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 700),
      tween: Tween(begin: 0.88, end: 1.0),
      curve: Curves.easeOutBack,
      builder: (_, value, child) => Transform.scale(
        scale: value,
        child: Transform.translate(offset: Offset(0, (1 - value) * 25), child: child),
      ),
      child: Hero(
        tag: 'ad_car_${ad.title}',
        child: Stack(alignment: Alignment.center, children: [_buildGlow(), _buildImage()]),
      ),
    );
  }

  Widget _buildGlow() {
    return Positioned(
      bottom: 0,
      child: Container(
        width: 130.w,
        height: 18.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          boxShadow: [
            BoxShadow(
              color: ad.accentColor.withValues(alpha: 0.3),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    return SizedBox(
      height: 130.h,
      child: ad.image.startsWith('http')
          ? CustomNetworkImage(imageUrl: ad.image, fit: BoxFit.contain)
          : Image.asset(
              ad.image,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => Icon(
                Icons.directions_car_rounded,
                size: 80.sp,
                color: ad.accentColor.withValues(alpha: 0.4),
              ),
            ),
    );
  }
}
