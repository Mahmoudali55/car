import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InspectionBadgeWidget extends StatelessWidget {
  const InspectionBadgeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColor.primaryColor(context).withOpacity(0.08),
            AppColor.primaryColor(context).withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.primaryColor(context).withOpacity(0.15)),
      ),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 44.w,
                height: 44.w,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
              ),
              Icon(
                Icons.verified_rounded,
                color: AppColor.primaryColor(context),
                size: 28.sp,
              ),
            ],
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocaleKey.reliableCarSubtitle.tr(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.w900,
                    color: AppColor.blackTextColor(context),
                  ),
                ),
                Text(
                  AppLocaleKey.reliableCarDescription.tr(),
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.greyColor(context),
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.shield_outlined,
            color: AppColor.primaryColor(context).withOpacity(0.3),
            size: 24.sp,
          ),
        ],
      ),
    );
  }
}
