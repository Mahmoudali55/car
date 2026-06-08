import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/home/presentation/view/widgets/card_footer_widget.dart';
import 'package:car/features/home/presentation/view/widgets/card_image_widget.dart';
import 'package:car/features/home/presentation/view/widgets/card_top_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MagazineCardWidget extends StatelessWidget {
  const MagazineCardWidget({super.key, required this.car, this.heroTag});

  final Map<String, dynamic> car;
  final String? heroTag;

  void _navigateToDetails(BuildContext context) {
    NavigatorMethods.pushNamed(
      context,
      RoutesName.carDetailsScreen,
      arguments: {'car': car, 'heroTag': heroTag},
    );
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
                CardImage(car: car, heroTag: heroTag),
                CardTopBar(car: car),
              ],
            ),
            CardFooter(car: car),
          ],
        ),
      ),
    );
  }
}

