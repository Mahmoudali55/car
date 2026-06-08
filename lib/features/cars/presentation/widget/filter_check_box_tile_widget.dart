import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterCheckboxTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const FilterCheckboxTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12.r),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyle.bodyLarge(context).copyWith(
                  color: AppColor.blackTextColor(context).withValues(alpha: (0.70)),
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor: AppColor.blackTextColor(context).withValues(alpha: (0.24)),
              ),
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: AppColor.primaryColor(context),
                checkColor: AppColor.whiteColor(context),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
