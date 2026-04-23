import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchBar extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchBar({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context).withValues(alpha: (0.5))),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: (0.03)),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: CustomFormField(
          onChanged: onChanged,
          hintText: AppLocaleKey.agentSearchCustomerCarNumber.tr(),
          hintStyle: TextStyle(
            color: AppColor.hintColor(context),
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColor.hintColor(context).withValues(alpha: (0.6)),
            size: 22.sp,
          ),
        ),
      ),
    );
  }
}
