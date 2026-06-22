import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(28.w),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor(context).withValues(alpha: 0.06),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.receipt_long_rounded,
                    color: AppColor.primaryColor(context).withValues(alpha: 0.45),
                    size: 56.sp,
                  ),
                ),
                Gap(20.h),
                Text(
                  AppLocaleKey.no_offers.tr(),
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w700),
                ),
                Gap(8.h),
                Text(
                  AppLocaleKey.no_offers_desc.tr(),
                  textAlign: TextAlign.center,
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context), height: 1.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
