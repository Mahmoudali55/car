import 'dart:ui';

import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassFieldWidget extends StatelessWidget {
  const GlassFieldWidget({
    super.key,
    required this.hint,
    this.keyboardType,
    required this.maxLines,
  });
  final String hint;
  final TextInputType? keyboardType;
  final int maxLines;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withOpacity(0.03),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
          ),
          child: TextField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: TextStyle(color: AppColor.blackTextColor(context)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColor.blackTextColor(context).withOpacity(0.2),
                fontSize: 13.sp,
              ),
              contentPadding: EdgeInsets.all(20.w),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
