import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cars/presentation/widget/car_header_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationCarSummary extends StatelessWidget {
  final GetBrandCarsDataModel car;

  const ReservationCarSummary({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: CarHeaderWidget(car: car),
    );
  }
}
