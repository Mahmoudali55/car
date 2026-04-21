import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/features/home/presentation/view/widgets/custom_price_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';


class BankInstallmentsBannerWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const BankInstallmentsBannerWidget({super.key, required this.car});

  String _getInstallmentPrice() {
    // Check multiple potential keys for installment price
    final price = car['installments'] ?? 
                 
                 '---';
    return price.toString();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RoutesName.financingScreen, arguments: car);
      },
      child: CustomPriceWidget(
        car: car,
        title: AppLocaleKey.installments.tr(),
        price: _getInstallmentPrice(),
      ),
    );
  }
}
