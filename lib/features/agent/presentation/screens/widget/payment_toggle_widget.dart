import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/agent/presentation/screens/widget/payment_option_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentToggle extends StatelessWidget {
  final String value;

  final ValueChanged<String> onChanged;
  final BuildContext context;
  const PaymentToggle({
    super.key,
    required this.value,

    required this.onChanged,
    required this.context,
  });

  @override
  Widget build(BuildContext ctx) {
    return Row(
      children: [
        PaymentOption(
          label: AppLocaleKey.cash.tr(),
          icon: Icons.payments_rounded,
          code: 'CSH',
          selected: value == 'CSH',
          onTap: () => onChanged('CSH'),
          context: context,
        ),
        Gap(12.w),
        PaymentOption(
          label: AppLocaleKey.crad.tr(),
          icon: Icons.schedule_rounded,
          code: 'CRD',
          selected: value == 'CRD',
          onTap: () => onChanged('CRD'),
          context: context,
        ),
      ],
    );
  }
}
