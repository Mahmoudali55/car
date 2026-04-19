import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationExpiredView extends StatelessWidget {
  final VoidCallback onOkPressed;

  const ReservationExpiredView({super.key, required this.onOkPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInUp(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_off_rounded, size: 80.sp, color: Colors.red),
              Gap(24.h),
              Text(
                AppLocaleKey.reservationExpired.tr(),
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blackTextColor(context),
                ),
              ),
              Gap(12.h),
              Text(
                AppLocaleKey.reservationExpiredDesc.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], height: 1.5),
              ),
              Gap(40.h),
              CustomButton(
                height: 50.h,
                width: 200.w,
                radius: 12.r,
                onPressed: onOkPressed,
                child: Text(AppLocaleKey.ok.tr(), style: AppTextStyle.buttonStyle(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
