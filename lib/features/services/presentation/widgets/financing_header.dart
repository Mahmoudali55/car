import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingHeader extends StatelessWidget {
  const FinancingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
            ),
          ),
          const Spacer(),
          Column(
            children: [
              Text(
                AppLocaleKey.financingSolutions.tr().toUpperCase(),
                style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.w900),
              ),
              Gap(6.h),
              Container(
                height: 1.5.h,
                width: 100.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColor.blackTextColor(context).withValues(alpha: 0.1),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(1.r),
                ),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
