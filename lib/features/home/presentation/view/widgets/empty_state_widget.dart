import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({required this.isBrandSelected});

  final bool isBrandSelected;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.car_rental_rounded,
                size: 80.sp,
                color: AppColor.greyColor(context).withValues(alpha: 0.3),
              ),
              Gap(20.h),
              Text(
                isBrandSelected
                    ? AppLocaleKey.agentNoCarsAvailable.tr()
                    : AppLocaleKey.agentNoCars.tr(),
                textAlign: TextAlign.center,
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
