import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AboutVideoSection extends StatelessWidget {
  final Widget player;

  const AboutVideoSection({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocaleKey.companyVideoTitle.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColor.blackTextColor(context),
          ),
        ),
        Gap(16.h),
        Container(
          height: 200.h,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: player,
        ),
      ],
    );
  }
}
