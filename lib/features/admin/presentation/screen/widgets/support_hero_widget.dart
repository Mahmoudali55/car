import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SupportHeroWidget extends StatelessWidget {
  const SupportHeroWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        decoration: BoxDecoration(
          color: AppColor.primaryColor(context).withOpacity(0.05),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColor.primaryColor(context).withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.help_center_rounded,
                color: AppColor.primaryColor(context),
                size: 32.sp,
              ),
            ),
            Gap(20.h),
            Text(
              AppLocaleKey.adminHelpHero.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.h),
            Text(
              AppLocaleKey.adminHelpDesc.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.blackTextColor(context).withOpacity(0.5),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
