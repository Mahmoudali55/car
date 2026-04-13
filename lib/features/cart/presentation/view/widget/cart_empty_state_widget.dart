import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartEmptyStateWidget extends StatelessWidget {
  const CartEmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.secondAppColor(context),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: AppColor.blackTextColor(context).withOpacity(0.3),
              size: 55.sp,
            ),
          ),
          Gap(24.h),
          Text(
            AppLocaleKey.cartEmptyTitle.tr(),
            style: AppTextStyle.titleMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          Gap(12.h),
          Text(
            AppLocaleKey.cartEmptySubtitle.tr(),
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context).withOpacity(0.5),
            ),
            textAlign: TextAlign.center,
          ),
          Gap(32.h),
          CustomButton(
            radius: 12.r,
            height: 50.h,
            width: 180.w,
            text:  AppLocaleKey.browseCars.tr(),
            onPressed: () {
               Navigator.pop( context);
              // Navigate to the shopping screen or home screen
            },
          ),
        ],
      ),
    );
  }
}

