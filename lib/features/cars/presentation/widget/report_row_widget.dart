import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReportRowWidget extends StatelessWidget {
  const ReportRowWidget({super.key, required this.title, required this.isHealthy});
  final String title;
  final bool isHealthy;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isHealthy ? Icons.check_circle_rounded : Icons.warning_rounded,
          color: isHealthy ? AppColor.greenColor(context) : Colors.orangeAccent,
          size: 20.sp,
        ),
        Gap(12.w),
        Text(
          title,
          style: AppTextStyle.bodyMedium(context).copyWith(color: AppColor.blackTextColor(context)),
        ),
        const Spacer(),
        Text(
          isHealthy ? AppLocaleKey.salem.tr() : AppLocaleKey.attention.tr(),
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.9)),
        ),
      ],
    );
  }
}
