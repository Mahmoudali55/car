import 'package:car/core/routes/routes_name.dart';
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
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
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
