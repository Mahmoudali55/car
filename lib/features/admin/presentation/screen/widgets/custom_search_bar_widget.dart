import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSearchBarWidget extends StatelessWidget {
  const CustomSearchBarWidget({
    super.key,

    required this.controller,
    required this.hintText,
    required this.onSearch,
  });

  final TextEditingController controller;
  final String hintText;
  final ValueChanged<String> onSearch;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: CustomFormField(
        radius: 12.r,
        controller: controller,
        onChanged: (value) {
          onSearch(value.trim());
        },
        hintText: hintText,
        hintStyle: AppTextStyle.bodySmall(
          context,
        ).copyWith(color: AppColor.blackTextColor(context).withValues(alpha: 0.3)),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
          size: 20.sp,
        ),
        suffixIcon: ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder: (context, value, child) {
            if (value.text.isEmpty) return const SizedBox.shrink();
            return IconButton(
              onPressed: () {
                controller.clear();
                onSearch('');
              },
              icon: Icon(
                Icons.clear_rounded,
                color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                size: 18.sp,
              ),
            );
          },
        ),
      ),
    );
  }
}
