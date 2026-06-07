import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/home/presentation/view/widgets/arrow_button_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PriceRow extends StatelessWidget {
  const PriceRow({required this.car});

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${car['oldPrice']} ${AppLocaleKey.sar.tr()}',
                style: TextStyle(
                  color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                  fontSize: 9.sp,
                  decoration: TextDecoration.lineThrough,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Gap(3.h),
              Text(
                '${car['price']} ${AppLocaleKey.sar.tr()}',
                style: TextStyle(
                  color: AppColor.blackTextColor(context),
                  fontWeight: FontWeight.w900,
                  fontSize: 13.sp,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Gap(8.w),
        const ArrowButton(),
      ],
    );
  }
}
