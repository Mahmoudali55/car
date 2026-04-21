import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FaqItemWidget extends StatelessWidget {
  const FaqItemWidget({super.key, required this.question, required this.answer});
  final String question;
  final String answer;
  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.02),
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              question,
              style: TextStyle(color: baseColor, fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            Gap(8.h),
            Text(
              answer,
              style: TextStyle(color: baseColor.withOpacity(0.5), fontSize: 11.sp),
            ),
          ],
        ),
      ),
    );
  }
}
