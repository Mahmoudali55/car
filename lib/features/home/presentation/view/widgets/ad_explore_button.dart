import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/data/model/ad_item_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdExploreButton extends StatelessWidget {
  final AdItem ad;
  final VoidCallback? onTap;

  const AdExploreButton({super.key, required this.ad, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(color: ad.accentColor, borderRadius: BorderRadius.circular(20.r)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppLocaleKey.explore.tr(),
              style: AppTextStyle.bodySmall(
                context,
              ).copyWith(color: ad.bgColors.first, fontWeight: FontWeight.w700),
            ),
            Gap(5.w),
            Icon(Icons.arrow_forward_rounded, size: 13.w, color: ad.bgColors.first),
          ],
        ),
      ),
    );
  }
}
