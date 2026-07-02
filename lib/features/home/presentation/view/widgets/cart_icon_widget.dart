import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartIconWidget extends StatelessWidget {
  const CartIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.center,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.greyColor(context).withValues(alpha: 0.1),
              child: IconButton(
                onPressed: () => Navigator.pushNamed(context, RoutesName.cartScreen),
                icon: Icon(Icons.shopping_cart_outlined, color: AppColor.blackTextColor(context)),
              ),
            ),
            if (state.reservedCars.isNotEmpty)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: AppColor.redColor(context),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    state.itemCount.toString(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.whiteColor(context),
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
