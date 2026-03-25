import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.offerCenter.tr(),
                    style: AppTextStyle.titleLarge(context).copyWith(
                      color: AppColor.whiteColor(context),
                      fontWeight: FontWeight.w900,
                      fontSize: 30.sp,
                    ),
                  ),
                  Text(
                    AppLocaleKey.bestDeals.tr(),
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: Colors.white38),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.auto_awesome,
                  color: AppColor.primaryColor(context),
                  size: 24.sp,
                ),
              ),
            ],
          ),
          Gap(20.h),
          CustomFormField(
            hintText: AppLocaleKey.searchForOffers.tr(),
            prefixIcon: const Icon(Icons.search_rounded, color: Colors.white24),
          ),
        ],
      ),
    );
  }
}
