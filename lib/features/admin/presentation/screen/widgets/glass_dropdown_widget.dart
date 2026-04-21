import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GlassDropdownWidget extends StatelessWidget {
  const GlassDropdownWidget({
    super.key,
    required this.hint,
    required this.items,
    this.value,
    required this.onChanged,
  });
  final String hint;
  final List<String> items;
  final String? value;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withOpacity(0.03),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(
            hint,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withOpacity(0.2),
              fontSize: 13.sp,
            ),
          ),
          isExpanded: true,
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 13.sp),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
