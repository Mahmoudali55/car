import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AboutBioSection extends StatelessWidget {
  const AboutBioSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 4.w,
              height: 24.h,
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Gap(12.w),
            Text(
              AppLocaleKey.carApp.tr(),
              style: AppTextStyle.titleLarge(context).copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ),
          ],
        ),
        Gap(16.h),
        Text(
          AppLocaleKey.companyBio.tr(),
          style: TextStyle(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
            fontSize: 15.sp,
            height: 1.8,
          ),
        ),
      ],
    );
  }
}
