import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/home/presentation/view/widgets/card_details_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'card_image_section.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.car});

  final Map<String, dynamic> car;

  void _navigateToDetails(BuildContext context) {
    NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.07)),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor(context).withValues(alpha: 0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(flex: 5, child: CardImageSection(car: car)),
            Expanded(flex: 6, child: CardDetailsSection(car: car)),
          ],
        ),
      ),
    );
  }
}
