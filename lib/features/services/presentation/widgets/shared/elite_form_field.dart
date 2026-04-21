import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EliteFormField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType type;

  const EliteFormField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.type = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, bottom: 10.h),
          child: Text(
            label,
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context).withOpacity(0.6),
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withOpacity(0.03),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColor.borderColor(context)),
          ),
          child: CustomFormField(
            hintText: hint,
            controller: controller,
            keyboardType: type,
            hintStyle: TextStyle(
              color: AppColor.blackTextColor(context).withOpacity(0.3),
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
              letterSpacing: 0.5,
            ),
            validator: (v) => v!.isEmpty ? 'REQUIRED_FIELD' : null,
          ),
        ),
      ],
    );
  }
}
