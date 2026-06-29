import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/view/widgets/spec_badge_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardFooter extends StatelessWidget {
  const CardFooter({super.key, required this.car});

  final Map<String, dynamic> car;

  @override
  Widget build(BuildContext context) {
    final String? priceRaw = car['price']?.toString();
    final bool hasPrice =
        priceRaw != null && priceRaw != '0' && priceRaw.isNotEmpty && priceRaw != 'null';

    // الحصول على نسبة الضريبة من الـ API
    final String? vatSerial = HiveMethods.getVatNumber();
    final double vatPercentage = double.tryParse(vatSerial.toString()) ?? 15;

    // حساب السعر شامل الضريبة
    String priceWithVatText = '0';
    if (hasPrice) {
      final cleanPrice = priceRaw!.replaceAll(RegExp(r'[^0-9,]'), '');
      final numericPrice = cleanPrice.replaceAll(',', '');
      final double originalPrice = double.tryParse(numericPrice) ?? 0;
      final double priceWithVat = originalPrice * (1 + (vatPercentage / 100));

      // تنسيق السعر مع الضريبة
      priceWithVatText = priceWithVat.toStringAsFixed(0); // أو استخدم NumberFormat
    }

    // نص السعر المعروض (السعر الأصلي + السعر مع الضريبة)
    final String displayPriceText = hasPrice
        ? '$priceRaw ${AppLocaleKey.sar.tr()}'
        : '0 ${AppLocaleKey.sar.tr()}';

    // نص السعر شامل الضريبة
    final String vatPriceText = hasPrice
        ? '${priceWithVatText} ${AppLocaleKey.sar.tr()} (شامل الضريبة)'
        : '0 ${AppLocaleKey.sar.tr()}';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 20.h),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        border: Border(
          top: BorderSide(color: AppColor.blackTextColor(context).withValues(alpha: 0.06)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(8.h),
          Text(
            car['name'] ?? '',
            style: AppTextStyle.titleMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900),
          ),
          Gap(12.h),
          // السعر الأصلي
          Row(
            children: [
              ValueWithCurrencyIcon(
                text: displayPriceText,
                textStyle: AppTextStyle.titleMedium(context).copyWith(
                  color: hasPrice ? AppColor.primaryColor(context) : AppColor.greyColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (hasPrice) ...[
            Gap(4.h),
            Row(
              children: [
                ValueWithCurrencyIcon(
                  text: '$priceWithVatText ${AppLocaleKey.sar.tr()}',
                  textStyle: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w600),
                ),
                Gap(8.w),
                Text(
                  AppLocaleKey.taxIncluded.tr(),
                  style: AppTextStyle.bodySmall(
                    context,
                  ).copyWith(color: AppColor.greyColor(context)),
                ),
              ],
            ),
          ],
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SpecBadgeWidget(
                icon: Icons.calendar_today_rounded,
                text: car['year']?.toString() ?? 'N/A',
              ),
              SpecBadgeWidget(icon: Icons.speed_rounded, text: car['mileage'] ?? '0 كم'),
              SpecBadgeWidget(icon: Icons.electric_bolt_rounded, text: car['engine'] ?? 'N/A'),
            ],
          ),
        ],
      ),
    );
  }
}
