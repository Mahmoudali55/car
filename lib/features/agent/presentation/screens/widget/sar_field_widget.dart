import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SarField extends StatelessWidget {
  final TextEditingController controller;
  final BuildContext context;
  final ValueChanged<String>? onChanged;
  const SarField({super.key, required this.controller, required this.context, this.onChanged});

  @override
  Widget build(BuildContext ctx) {
    return CustomFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      hintText: '0',
      onChanged: onChanged,
      suffixIcon: Padding(
        padding: EdgeInsets.all(12.w),
        child: SvgPicture.asset(
          AppImages.sar,
          height: 20.h,
          colorFilter: ColorFilter.mode(AppColor.primaryColor(context), BlendMode.srcIn),
        ),
      ),
      validator: (v) => null,
    );
  }
}
