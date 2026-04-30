import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/price_row_widget.dart';
import 'package:car/features/home/presentation/view/widgets/specs_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardDetailsSection extends StatelessWidget {
  const CardDetailsSection({required this.car});

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            car['brand'],
            style: TextStyle(
              color: AppColor.primaryColor(context),
              fontSize: 10.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Gap(6.h),
          Text(
            car['name'],
            style: AppTextStyle.titleSmall(
              context,
            ).copyWith(fontWeight: FontWeight.w900, fontSize: 13.sp),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          SpecsRow(car: car),
          Gap(10.h),
          PriceRow(car: car),
        ],
      ),
    );
  }
}
