import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({super.key, required this.icon, required this.title, this.onTap});
  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.borderColor(context).withValues(alpha: .1)),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor(context).withValues(alpha: .02),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColor.blueColor(context), size: 28.sp),
            Gap(8.h),
            Text(
              title,
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(fontWeight: FontWeight.w800, color: AppColor.blueColor(context)),
            ),
          ],
        ),
      ),
    );
  }
}
