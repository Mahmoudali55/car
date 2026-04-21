import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingContactForm extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final ValueNotifier<bool> whatsappNotifier;
  final ValueNotifier<String?> selectedCityNotifier;

  const FinancingContactForm({
    super.key,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.whatsappNotifier,
    required this.selectedCityNotifier,
  });

  @override
  State<FinancingContactForm> createState() => _FinancingContactFormState();
}

class _FinancingContactFormState extends State<FinancingContactForm> {
  final List<String> _cities = [
    'الرياض',
    'جدة',
    'مكة المكرمة',
    'المدينة المنورة',
    'الدمام',
    'الخبر',
    'الظهران',
    'أبها',
    'تبوك',
    'بريدة',
    'حائل',
    'نجران',
    'جازان',
    'الطائف',
    'الجبيل',
  ];

  final _borderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomFormField(
          controller: widget.firstNameController,
          hintText: 'الاسم الاول',
          radius: _borderRadius,
          validator: (v) => (v == null || v.isEmpty) ? 'الاسم مطلوب' : null,
        ),
        Gap(16.h),
        CustomFormField(
          controller: widget.lastNameController,
          hintText: 'اسم العائلة',
          radius: _borderRadius,
          validator: (v) => (v == null || v.isEmpty) ? 'اسم العائلة مطلوب' : null,
        ),
        Gap(16.h),
        CustomFormField(
          controller: widget.phoneController,
          hintText: 'رقم الجوال',
          radius: _borderRadius,
          keyboardType: TextInputType.phone,
          validator: (v) => (v == null || v.isEmpty) ? 'رقم الجوال مطلوب' : null,
        ),
        Gap(16.h),
        ValueListenableBuilder<bool>(
          valueListenable: widget.whatsappNotifier,
          builder: (context, val, _) {
            return GestureDetector(
              onTap: () => widget.whatsappNotifier.value = !val,
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(Icons.phone, color: const Color(0xff25D366), size: 20.sp),
                        Gap(8.w),
                        Text(
                          'أود استقبال تحديثات طلبي من خلال واتساب',
                          style: AppTextStyle.bodySmall(context).copyWith(
                            fontSize: 12.sp,
                            color: AppColor.blackTextColor(context).withOpacity(0.7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(12.w),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 22.w,
                    height: 22.w,
                    decoration: BoxDecoration(
                      color: val ? AppColor.primaryColor(context) : Colors.transparent,
                      borderRadius: BorderRadius.circular(6.r),
                      border: Border.all(
                        color: val ? AppColor.primaryColor(context) : Colors.grey,
                        width: 1.5,
                      ),
                    ),
                    child: val
                        ? Icon(Icons.check_rounded, color: Colors.white, size: 14.sp)
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
        Gap(24.h),
        Text(
          'المدينة',
          style: AppTextStyle.bodyMedium(context).copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 16.sp,
          ),
        ),
        Gap(12.h),
        ValueListenableBuilder<String?>(
          valueListenable: widget.selectedCityNotifier,
          builder: (context, selectedCity, _) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.borderColor(context)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedCity,
                  isExpanded: true,
                  hint: Text('اختر المدينة', style: AppTextStyle.bodyMedium(context).copyWith(color: Colors.grey)),
                  icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.blackTextColor(context)),
                  items: _cities.map((city) => DropdownMenuItem(
                    value: city,
                    child: Text(city, style: AppTextStyle.bodyMedium(context)),
                  )).toList(),
                  onChanged: (v) => widget.selectedCityNotifier.value = v,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
