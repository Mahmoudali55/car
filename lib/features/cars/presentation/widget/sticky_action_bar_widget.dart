import 'dart:ui';

import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class StickyActionBarWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const StickyActionBarWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Container(
            padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 40.h),
            decoration: BoxDecoration(
              color: AppColor.scaffoldColor(context).withValues(alpha: 0.8),
              border: Border(
                top: BorderSide(color: AppColor.whiteColor(context).withValues(alpha: 0.08)),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      final isInCart = context.read<CartCubit>().isInCart(car['name'] ?? '');
                      return ElevatedButton(
                        onPressed: () {
                          if (HiveMethods.getToken() == null) {
                            CommonMethods.showLoginRequiredDialog(context);
                          } else {
                            if (isInCart) {
                              context.read<CartCubit>().removeFromCart(car);
                            } else {
                              context.read<CartCubit>().addToCart(car);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isInCart
                              ? Colors.redAccent.withValues(alpha: 0.8)
                              : AppColor.primaryColor(context),
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                          elevation: 10,
                          shadowColor: AppColor.primaryColor(context).withValues(alpha: 0.3),
                        ),
                        child: Text(
                          isInCart ? AppLocaleKey.removeFromCart.tr() : AppLocaleKey.addToCart.tr(),
                          style: AppTextStyle.buttonStyle(
                            context,
                          ).copyWith(fontWeight: FontWeight.w900),
                        ),
                      );
                    },
                  ),
                ),
                Gap(16.w),
                Container(
                  height: 56.h,
                  width: 56.h,
                  decoration: BoxDecoration(
                    color: const Color(0xff25D366),
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff25D366).withValues(alpha: 0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(Icons.phone_rounded, color: AppColor.whiteColor(context), size: 28),
                    onPressed: () {
                      if (HiveMethods.getToken() == null) {
                        CommonMethods.showLoginRequiredDialog(context);
                      } else {
                        // TODO: Implement Phone Call
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
