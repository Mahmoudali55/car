import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ErrorState extends StatelessWidget {
  const ErrorState({required this.message, required this.onRetry});
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.redColor(context).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.wifi_off_rounded, color: AppColor.redColor(context), size: 48.sp),
            ),
            Gap(20.h),
            Text(
              AppLocaleKey.noData.tr(),
              style: AppTextStyle.titleMedium(
                context,
              ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w700),
            ),
            Gap(8.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
            ),
            Gap(24.h),
            SizedBox(
              width: 160.w,
              height: 44.h,
              child: ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor(context),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                icon: Icon(Icons.refresh_rounded, color: AppColor.whiteColor(context), size: 18),
                label: Text(
                  AppLocaleKey.retry.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                  ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
