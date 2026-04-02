import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class YearSelector extends StatelessWidget {
  final int selectedYear;
  final ValueChanged<int> onChanged;

  const YearSelector({super.key, required this.selectedYear, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
      child: DropdownButton<int>(
        value: selectedYear,
        isExpanded: true,
        underline: Container(),
        icon: Icon(
          Icons.keyboard_arrow_down_rounded,
          color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
        ),
        dropdownColor: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        items: List.generate(7, (i) => 2026 - i).map((year) {
          return DropdownMenuItem<int>(
            value: year,
            child: Text(
              '$year',
              style: AppTextStyle.bodyMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                color: AppColor.blackTextColor(context),
                fontSize: 14.sp,
              ),
            ),
          );
        }).toList(),
        onChanged: (val) => onChanged(val!),
      ),
    );
  }
}
