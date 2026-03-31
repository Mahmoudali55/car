import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/widget/cart_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartItemsListWidget extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CartItemsListWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.primaryColor(context).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColor.primaryColor(context).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart_rounded,
                  color: AppColor.primaryColor(context),
                  size: 18.sp,
                ),
                Gap(10.w),
                Text(
                  '${items.length} ${items.length == 1 ? AppLocaleKey.cartCarSingular.tr() : AppLocaleKey.cartCarPlural.tr()} ${AppLocaleKey.inYourCart.tr()}',
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          ...items.map((car) => CartItemWidget(car: car)),
          Gap(16.h),
        ],
      ),
    );
  }
}

