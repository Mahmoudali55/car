import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EliteInputField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String suffix;
  final String? hint;

  const EliteInputField({
    super.key,
    required this.label,
    required this.controller,
    required this.suffix,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall(context).copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 11.sp,
            letterSpacing: 1.5,
            color: AppColor.blackTextColor(context).withOpacity(0.7),
          ),
        ),
        Gap(12.h),
        Container(
          decoration: BoxDecoration(
            color: AppColor.cardColor(context),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
            ],
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.w900,
              fontSize: 14.sp,
              letterSpacing: 1,
            ),
            cursorColor: AppColor.primaryColor(context),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.blackTextColor(context).withOpacity(0.2),
              ),
              suffixIcon: Container(
                margin: EdgeInsets.only(right: 16.w, top: 14.h),
                child: Text(
                  suffix,
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.blackTextColor(context).withOpacity(0.4),
                    fontWeight: FontWeight.w900,
                    fontSize: 12.sp,
                  ),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(color: AppColor.primaryColor(context), width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
