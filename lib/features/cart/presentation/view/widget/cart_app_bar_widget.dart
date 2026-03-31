import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final int itemsCount;

  const CartAppBarWidget({super.key, required this.itemsCount});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.scaffoldColor(context),
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: AppColor.blackTextColor(context),
        ),
        onPressed: () => Navigator.pop(context),
        style: IconButton.styleFrom(
          backgroundColor: AppColor.blackTextColor(context).withOpacity(0.05),
        ),
      ),
      title: Text(
        AppLocaleKey.cartScreenTitle.tr(),
        style: AppTextStyle.titleMedium(
          context,
        ).copyWith(
          color: AppColor.blackTextColor(context),
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        if (itemsCount > 0)
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  backgroundColor: AppColor.secondAppColor(context),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  title: Text(
                    AppLocaleKey.clearCartDialogTitle.tr(),
                    style: AppTextStyle.titleMedium(
                      context,
                    ).copyWith(color: AppColor.blackTextColor(context)),
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    AppLocaleKey.clearCartDialogBody.tr(),
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(
                      color: AppColor.blackTextColor(context).withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        AppLocaleKey.cancel.tr(),
                        style: AppTextStyle.bodyMedium(
                          context,
                        ).copyWith(color: AppColor.blackTextColor(context)),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<CartCubit>().clearCart();
                        Navigator.pop(context);
                      },
                      child: Text(
                        AppLocaleKey.clearCartAction.tr(),
                        style: AppTextStyle.bodyMedium(
                          context,
                        ).copyWith(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              AppLocaleKey.clearCartAction.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: Colors.redAccent,
              ),
            ),
          ),
      ],
    );
  }
}

