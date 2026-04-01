import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingSuccessDialog extends StatelessWidget {
  const FinancingSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return FadeInRight(
      child: AlertDialog(
        backgroundColor: AppColor.secondAppColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Gap(20.h),
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 80.sp),
            ),
            Gap(32.h),
            Text(
              AppLocaleKey.requestSubmittedSuccess.tr().toUpperCase(),
              textAlign: TextAlign.center,
              style: AppTextStyle.titleMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
                fontSize: 18.sp,
              ),
            ),
            Gap(16.h),
            Text(
              AppLocaleKey.luxuryConciergeContact.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: AppColor.greyColor(context),
                fontSize: 13.sp,
              ),
            ),
            Gap(40.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to services
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.primaryColor(context),
                  padding: EdgeInsets.symmetric(vertical: 18.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                ),
                child: Text(
                  AppLocaleKey.ok.tr().toUpperCase(),
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.whiteColor(context),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            Gap(10.h),
          ],
        ),
      ),
    );
  }
}
