import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InfoBanner extends StatelessWidget {
  final VoidCallback onTap;

  const InfoBanner({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.borderColor(context)),
        ),
        child: Row(
          children: [
            TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                AppLocaleKey.agentKnowMore.tr(),
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.primaryColor(context),
                  fontWeight: FontWeight.w700,

                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            const Spacer(),
            Text(
              AppLocaleKey.agentRequiredDocuments.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.75),
                fontSize: 12.sp,
              ),
              textAlign: TextAlign.end,
            ),
            Gap(10.w),
            Icon(Icons.calendar_today_outlined, color: AppColor.primaryColor(context), size: 18.sp),
          ],
        ),
      ),
    );
  }
}
