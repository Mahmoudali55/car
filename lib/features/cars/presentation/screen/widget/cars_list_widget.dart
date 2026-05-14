import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/screen/widget/premium_car_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarsList extends StatelessWidget {
  const CarsList({required this.cars, required this.localizeCarData});

  final List<Map<String, dynamic>> cars;
  final Map<String, dynamic> Function(Map<String, dynamic>) localizeCarData;

  @override
  Widget build(BuildContext context) {
    if (cars.isEmpty) {
      return SizedBox(
        height: 200.h,
        child: Center(
          child: Text(
            AppLocaleKey.noCarsForBrand.tr(),
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.4)),
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 100.h),
      itemCount: cars.length,
      separatorBuilder: (_, __) => Gap(16.h),
      itemBuilder: (context, index) {
        final car = localizeCarData(cars[index]);
        return PremiumCarCardWidget(
          car: car,
          heroTag: 'premium_car_image_${car['itemCode'] ?? car['name']}',
        );
      },
    );
  }
}
