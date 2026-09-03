import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/cart/presentation/view/widget/cart_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartItemsListWidget extends StatelessWidget {
  final List<CarModel> cars;
  final String? selectedCarId;

  const CartItemsListWidget({super.key, required this.cars, this.selectedCarId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
        physics: const BouncingScrollPhysics(),
        children: [
          Card(
            margin: EdgeInsets.only(bottom: 20.h),
            color: AppColor.secondAppColor(context),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    Icons.shopping_cart_rounded,
                    color: AppColor.primaryColor(context),
                    size: 18.sp,
                  ),
                  Gap(10.w),
                  Text(
                    '${cars.length} ${cars.length == 1 ? AppLocaleKey.cartCarSingular.tr() : AppLocaleKey.cartCarPlural.tr()} ${AppLocaleKey.inYourCart.tr()}',
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),

          ..._orderedCars.map((car) => CartItemWidget(car: car)),
          Gap(16.h),
        ],
      ),
    );
  }

  List<CarModel> get _orderedCars {
    if (selectedCarId == null) return cars;
    final ordered = [...cars];
    ordered.sort((a, b) {
      final aSelected = a.itemCode == selectedCarId || a.lpoNo == selectedCarId;
      final bSelected = b.itemCode == selectedCarId || b.lpoNo == selectedCarId;
      return bSelected.toString().compareTo(aSelected.toString());
    });
    return ordered;
  }
}
