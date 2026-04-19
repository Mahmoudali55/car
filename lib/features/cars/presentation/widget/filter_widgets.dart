
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterSection extends StatelessWidget {
  final String title;
  final Widget child;

  const FilterSection({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Text(
            title,
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
        ),
        child,
      ],
    );
  }
}

