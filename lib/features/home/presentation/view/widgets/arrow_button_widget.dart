import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArrowButton extends StatelessWidget {
  const ArrowButton({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(7.w),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(Icons.arrow_forward_rounded, color: AppColor.whiteColor(context), size: 14.sp),
    );
  }
}
