import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TotalRow extends StatelessWidget {
  final String label;
  final num value;

  final BuildContext context;
  final Color color;

  const TotalRow({
    required this.label,
    required this.value,

    required this.context,
    required this.color,
  });

  @override
  Widget build(BuildContext ctx) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: color, fontWeight: FontWeight.w600),
        ),
        Text(
          '${NumberFormat('#,##0.##').format(value)} ${AppLocaleKey.sar.tr()}',
          style: AppTextStyle.bodySmall(
            context,
          ).copyWith(color: color, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
