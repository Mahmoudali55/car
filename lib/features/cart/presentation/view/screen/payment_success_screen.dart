import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentSuccessScreen extends StatefulWidget {
  const PaymentSuccessScreen({super.key});

  @override
  State<PaymentSuccessScreen> createState() => _PaymentSuccessScreenState();
}

class _PaymentSuccessScreenState extends State<PaymentSuccessScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _scaleAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );
    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.4, 1.0, curve: Curves.easeIn)),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Success Circle
                ScaleTransition(
                  scale: _scaleAnim,
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
                ),
                Gap(40.h),

                // Title
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    children: [
                      Text(
                        'تمّت عملية الدفع!',
                        style: AppTextStyle.titleLarge(context).copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 28.sp,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(16.h),
                      Text(
                        'شكراً لك! تم استلام طلبك بنجاح.\nسيتواصل معك فريقنا خلال 24 ساعة.',
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: Colors.white.withOpacity(0.6),
                          height: 1.6,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Gap(16.h),

                      // Order Number
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 24.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: AppColor.secondAppColor(context),
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.08)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.receipt_long_rounded,
                                color: AppColor.primaryColor(context),
                                size: 20.sp),
                            Gap(10.w),
                            Text(
                              'رقم الطلب: #CAR-${DateTime.now().millisecond.toString().padLeft(4, '0')}',
                              style: AppTextStyle.bodyMedium(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Gap(60.h),

                // Back Home Button
                FadeTransition(
                  opacity: _fadeAnim,
                  child: SizedBox(
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
                            borderRadius: BorderRadius.circular(18.r)),
                        elevation: 0,
                      ),
                      child: Text(
                        'العودة للرئيسية',
                        style: AppTextStyle.titleMedium(context).copyWith(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
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
