import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarSummaryCard extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarSummaryCard({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.borderColor(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              car['name'] ?? 'Car Name',
              style: AppTextStyle.bodyMedium(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            '${car['price'] ?? '0'} SAR',
            style: AppTextStyle.bodyMedium(context).copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
