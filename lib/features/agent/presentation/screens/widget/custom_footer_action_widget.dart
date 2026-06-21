import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/car_quotation_preview_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/quote_builder_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomFooterActionWidget extends StatelessWidget {
  const CustomFooterActionWidget({
    super.key,
    required this.widget,
    required List<String> instantSpecs,
    required TextEditingController priceController,
  }) : _instantSpecs = instantSpecs,
       _priceController = priceController;

  final QuoteBuilderDialog widget;
  final List<String> _instantSpecs;
  final TextEditingController _priceController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(24.w),
      child: CustomButton(
        onPressed: () {
          final List<String> specsList = [];

          // 1. Add existingSpecs (Original/existing specs from the dialog map)
          widget.existingSpecs.forEach((key, value) {
            final trimmedValue = value.trim();
            if (trimmedValue.isNotEmpty && trimmedValue != '—' && trimmedValue != '-') {
              specsList.add('$key: $trimmedValue');
            }
          });

          // 2. Add the original carSpecification from the model if any
          if (widget.car.carSpecification != null &&
              widget.car.carSpecification!.trim().isNotEmpty) {
            specsList.add(widget.car.carSpecification!.trim());
          }

          // 3. Add new specifications added in the dialog
          specsList.addAll(_instantSpecs);

          final updatedCar = widget.car.copyWith(
            price: _priceController.text,
            carSpecification: specsList.join(' | '),
          );

          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CarQuotationPreviewScreen(car: updatedCar)),
            );
          }
        },
        radius: 16.r,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.download_rounded, color: AppColor.whiteColor(context)),
            Gap(10.w),
            Text(
              AppLocaleKey.downloadQuote.tr(),
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
