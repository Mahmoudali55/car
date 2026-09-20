import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ContactRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final VoidCallback onCopy;

  const ContactRow({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(9.w),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  Gap(2.h),
                  Text(
                    subtitle,
                    style: AppTextStyle.bodySmall(
                      context,
                    ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.6)),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.copy_rounded, size: 18.sp, color: AppColor.primaryColor(context)),
              onPressed: onCopy,
              tooltip: AppLocaleKey.copy.tr(),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 14.sp,
              color: AppColor.primaryColor(context),
            ),
          ],
        ),
      ),
    );
  }
}
