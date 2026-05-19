import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppLocaleKey.availableCars.tr(),
            style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            AppLocaleKey.showAll.tr(),
            style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.primaryColor(context)),
          ),
        ],
      ),
    );
  }
}
