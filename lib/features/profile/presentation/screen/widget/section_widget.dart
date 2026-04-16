import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SectionWidget extends StatelessWidget {
  const SectionWidget({super.key, required this.title, required this.children});
final String title;
final List<Widget> children;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cardColor(context),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.dividerColor(context).withValues(alpha: 0.5)),
          ),
          child: Column(
            children: List.generate(children.length, (index) {
              return Column(
                children: [
                  children[index],
                  if (index != children.length - 1)
                    Divider(
                      height: 1,
                      indent: 50.w,
                      endIndent: 20.w,
                      color: AppColor.dividerColor(context).withValues(alpha: 0.3),
                    ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}