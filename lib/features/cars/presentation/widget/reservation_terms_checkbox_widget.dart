import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/reservation_terms_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReservationTermsCheckboxWidget extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ReservationTermsCheckboxWidget({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withValues(alpha: 0.05),
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
          Expanded(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  isArabic ? 'أوافق على ' : 'I agree to the ',
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () => showReservationTermsBottomSheet(context),
                  child: Text(
                    isArabic ? 'الشروط والأحكام' : 'Terms & Conditions',
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.primaryColor(context),
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColor.primaryColor(context),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
