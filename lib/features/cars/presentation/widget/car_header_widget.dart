import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const CarHeaderWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (car['brand'] ?? '').toUpperCase(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.w800,
                    letterSpacing: 2,
                  ),
                ),
                Gap(4.h),
                Text(
                  car['name'] ?? '',
                  style: AppTextStyle.titleLarge(context).copyWith(
                    fontSize: 28.sp,
                    color: AppColor.blackTextColor(context),
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ],
        ),
        Gap(16.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              car['price'] ?? '0',
              style: AppTextStyle.titleLarge(context).copyWith(
                color: AppColor.primaryColor(context),
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.w),
            Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Text(
                AppLocaleKey.taxIncluded.tr(),
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
