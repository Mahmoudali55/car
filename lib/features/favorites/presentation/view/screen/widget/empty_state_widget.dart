import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: AppColor.secondAppColor(context),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 80.sp,
              color: AppColor.greyColor(context).withValues(alpha: 0.2),
            ),
          ),
          Gap(24.h),
          Text(
            AppLocaleKey.noFavoritesYet.tr(),
            style: AppTextStyle.titleMedium(
              context,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Gap(8.h),
          Text(
            AppLocaleKey.addCarsToFavorites.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
          ),
        ],
      ),
    );
  }
}
