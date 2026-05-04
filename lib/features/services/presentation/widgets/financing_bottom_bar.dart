import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingBottomBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const FinancingBottomBar({
    required this.currentIndex,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          if (currentIndex > 0) ...[
            CustomButton(
              radius: 14.r,
              color: AppColor.cardColor(context),
              borderColor: AppColor.primaryColor(context),
              width: 50.w,
              onPressed: onBack,
              child: Icon(
                Icons.arrow_forward_rounded,
                color: AppColor.primaryColor(context),
                size: 20.sp,
              ),
            ),
            Gap(12.w),
          ],
          Expanded(
            child: CustomButton(
              radius: 14.r,
              color: AppColor.primaryColor(context),
              onPressed: onNext,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (currentIndex < 2) ...[
                    Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.whiteColor(context),
                      size: 18.sp,
                    ),
                    Gap(10.w),
                  ],
                  Text(
                    currentIndex == 2
                        ? AppLocaleKey.submitApplication.tr()
                        : AppLocaleKey.agentNext.tr(),
                    style: AppTextStyle.bodyLarge(
                      context,
                    ).copyWith(color: AppColor.whiteColor(context)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
