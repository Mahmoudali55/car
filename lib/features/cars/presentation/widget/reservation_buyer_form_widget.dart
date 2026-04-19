import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationBuyerForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController ibanController;

  const ReservationBuyerForm({
    super.key,
    required this.nameController,
    required this.idController,
    required this.ibanController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Buyer Name
        Text(
          AppLocaleKey.buyerName.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.blackTextColor(context),
          ),
        ),
        Gap(8.h),
        CustomFormField(
          controller: nameController,
          hintText: AppLocaleKey.buyerNameHint.tr(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocaleKey.validateEmpty.tr();
            }
            return null;
          },
        ),
        Gap(16.h),

        // Buyer ID
        Text(
          AppLocaleKey.buyerId.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.blackTextColor(context),
          ),
        ),
        Gap(8.h),
        CustomFormField(
          controller: idController,
          hintText: '10XXXXXX',
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocaleKey.validateEmpty.tr();
            }
            return null;
          },
        ),
        Gap(16.h),

        // Buyer IBAN
        Text(
          AppLocaleKey.buyerIban.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.blackTextColor(context),
          ),
        ),
        Gap(8.h),
        CustomFormField(
          controller: ibanController,
          hintText: 'SAXXXXXXXXXXXXXXXXXXXXXX',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return AppLocaleKey.validateEmpty.tr();
            }
            if (!value.startsWith('SA') && value.length < 10) {
              return AppLocaleKey.validateEmpty.tr(); // Generically invalid for demo
            }
            return null;
          },
        ),
      ],
    );
  }
}
