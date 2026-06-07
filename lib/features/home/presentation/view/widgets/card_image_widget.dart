import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/images/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CardImage extends StatelessWidget {
  const CardImage({super.key, required this.car, this.heroTag});

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
        child: imageUrl.trim().startsWith('http')
            ? CustomNetworkImage(
                imageUrl: imageUrl,
                fit: BoxFit.fill,
                width: double.infinity,
                height: 200.h,
              )
            : Image.asset(
                imageUrl.isNotEmpty ? imageUrl : AppImages.assetsImagesPlaceholder,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
