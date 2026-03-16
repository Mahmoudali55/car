import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatelessWidget {
  final Map<String, dynamic> car;

  const CartItemWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Car Image
          Container(
            width: 90.w,
            height: 70.h,
            decoration: BoxDecoration(
              color: AppColor.scaffoldColor(context),
              borderRadius: BorderRadius.circular(14.r),
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.asset(
              car['image'] as String,
              fit: BoxFit.contain,
            ),
          ),
          Gap(14.w),

          // Car Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  car['brand'] as String? ?? '',
                  style: AppTextStyle.bodySmall(context).copyWith(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(4.h),
                Text(
                  car['name'] as String? ?? '',
                  style: AppTextStyle.titleMedium(context).copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Gap(6.h),
                Text(
                  car['price'] as String? ?? '',
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),

          // Remove Button
          GestureDetector(
            onTap: () {
              context.read<CartCubit>().removeFromCart(car);
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
