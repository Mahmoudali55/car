import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SuccessCircleWidget extends StatelessWidget {
  final Animation<double> scaleAnim;
  const SuccessCircleWidget({super.key, required this.scaleAnim});

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnim,
      child: Container(
        width: 140.w,
        height: 140.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColor.primaryColor(context).withOpacity(0.3),
              AppColor.primaryColor(context).withOpacity(0.05),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor(context).withOpacity(0.4),
              blurRadius: 40,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Icon(
          Icons.check_circle_rounded,
          color: AppColor.primaryColor(context),
          size: 80.sp,
        ),
      ),
    );
  }
}

class PaymentSuccessHeader extends StatelessWidget {
  const PaymentSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          AppLocaleKey.paymentSuccessTitle.tr(),
          style: AppTextStyle.titleLarge(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 28.sp,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(16.h),
        Text(
          AppLocaleKey.paymentSuccessSubtitle.tr(),
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: AppColor.blackTextColor(context).withOpacity(0.6),
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class OrderNumberWidget extends StatelessWidget {
  const OrderNumberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final orderId = '${AppLocaleKey.paymentSuccessOrderPrefix.tr()}${DateTime.now().millisecond.toString().padLeft(4, '0')}';
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 14.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColor.blackTextColor(context).withOpacity(0.08),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.receipt_long_rounded,
            color: AppColor.primaryColor(context),
            size: 20.sp,
          ),
          Gap(10.w),
          Text(
            '${AppLocaleKey.orderNumberLabel.tr()} #$orderId',
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class BackToHomeButton extends StatelessWidget {
  const BackToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          context.read<CartCubit>().clearCart();
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesName.mainLayout,
            (route) => false,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor(context),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.r),
          ),
          elevation: 0,
        ),
        child: Text(
          AppLocaleKey.backToHome.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
