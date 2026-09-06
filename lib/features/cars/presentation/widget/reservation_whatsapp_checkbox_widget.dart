import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationWhatsAppCheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ReservationWhatsAppCheckboxWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: value
              ? AppColor.primaryColor(context).withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: value
                ? AppColor.primaryColor(context)
                : AppColor.borderColor(context).withValues(alpha: 0.5),
            width: value ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Checkbox(
              value: value,
              activeColor: AppColor.primaryColor(context),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
              onChanged: onChanged,
            ),
            Icon(Icons.phone, color: AppColor.greenColor(context), size: 20.sp),
            Gap(8.w),
            Expanded(
              child: Text(
                AppLocaleKey.whatsappUpdates.tr(),
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.blackTextColor(context),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
