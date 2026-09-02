import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, required this.onRetry});
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
              padding: EdgeInsets.all(28.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.account_balance_outlined,
                size: 56.sp,
                color: AppColor.primaryColor(context),
              ),
            ),
            Gap(20.h),
            Text(
              AppLocaleKey.noApplications.tr(),
              style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
            ),
            Gap(8.h),
            Text(
              AppLocaleKey.noApplicationsDesc.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium(context).copyWith(color: AppColor.greyColor(context)),
            ),
            Gap(24.h),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: Text(AppLocaleKey.tryAgain.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
