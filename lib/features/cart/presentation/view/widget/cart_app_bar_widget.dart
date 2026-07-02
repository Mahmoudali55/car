import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CartAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final int itemsCount;
  const CartAppBarWidget({super.key, required this.itemsCount});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      context,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        onPressed: () => Navigator.pop(context),
        style: IconButton.styleFrom(
          backgroundColor: AppColor.blackTextColor(context).withValues(alpha: 0.05),
        ),
      ),
      title: Text(
        AppLocaleKey.cartScreenTitle.tr(),
        style: AppTextStyle.titleMedium(
          context,
        ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
      ),
    );
  }
}
