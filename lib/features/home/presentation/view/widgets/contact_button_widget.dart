import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ContactButtonWidget extends StatelessWidget {
  const ContactButtonWidget({super.key, required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap,});
    final IconData icon;
    final String title;
    final String subtitle;
    final Color color;
    final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 24.sp),
            ),
            Gap(15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyle.titleMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.greyColor(context),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16.sp,
              color: AppColor.greyColor(context),
            ),
          ],
        ),
      ),
    );
  }
}