import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/cart/presentation/view/widget/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        final items = state.items;
        final totalPrice = state.totalPrice;

        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          appBar: AppBar(
            backgroundColor: AppColor.scaffoldColor(context),
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
              onPressed: () => Navigator.pop(context),
              style: IconButton.styleFrom(
                backgroundColor: AppColor.blackTextColor(context).withOpacity(0.05),
              ),
            ),
            title: Text(
              'سلة المشتريات',
              style: AppTextStyle.titleMedium(
                context,
              ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
            ),
            actions: [
              if (items.isNotEmpty)
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        backgroundColor: AppColor.secondAppColor(context),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                        title: Text(
                          'تفريغ السلة',
                          style: AppTextStyle.titleMedium(
                            context,
                          ).copyWith(color: AppColor.blackTextColor(context)),
                          textAlign: TextAlign.center,
                        ),
                        content: Text(
                          'هل تريد حذف جميع السيارات من السلة؟',
                          style: AppTextStyle.bodyMedium(
                            context,
                          ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.7)),
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'إلغاء',
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
                              'تفريغ',
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
                    'تفريغ',
                    style: AppTextStyle.bodySmall(context).copyWith(color: Colors.redAccent),
                  ),
                ),
            ],
          ),
          body: items.isEmpty
              ? _buildEmptyCart(context)
              : Column(
                  children: [
                    // Items List
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 0),
                        physics: const BouncingScrollPhysics(),
                        children: [
                          // Header Badge
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
                                  '${items.length} ${items.length == 1 ? 'سيارة' : 'سيارات'} في سلتك',
                                  style: AppTextStyle.bodyMedium(context).copyWith(
                                    color: AppColor.primaryColor(context),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Car Items
                          ...items.map((car) => CartItemWidget(car: car)),
                          Gap(16.h),
                        ],
                      ),
                    ),

                    // Bottom Summary & Pay Button
                    Container(
                      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 32.h),
                      decoration: BoxDecoration(
                        color: AppColor.scaffoldColor(context),
                        border: Border(
                          top: BorderSide(
                            color: AppColor.blackTextColor(context).withOpacity(0.06),
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Total Price Row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'الإجمالي',
                                style: AppTextStyle.titleMedium(context).copyWith(
                                  color: AppColor.blackTextColor(context).withOpacity(0.7),
                                ),
                              ),
                              Text(
                                '${totalPrice.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}  ر.س       ',
                                style: AppTextStyle.titleLarge(context).copyWith(
                                  color: AppColor.primaryColor(context),
                                  fontWeight: FontWeight.w900,
                                  fontSize: 22.sp,
                                ),
                              ),
                            ],
                          ),
                          Gap(16.h),

                          // Pay Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.paymentScreen,
                                  arguments: totalPrice,
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
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.payment_rounded,
                                    color: AppColor.blackTextColor(context),
                                    size: 22.sp,
                                  ),
                                  Gap(10.w),
                                  Text(
                                    'ادفع الآن',
                                    style: AppTextStyle.titleMedium(context).copyWith(
                                      color: AppColor.blackTextColor(context),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buildEmptyCart(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.secondAppColor(context),
            ),
            child: Icon(
              Icons.shopping_cart_outlined,
              color: AppColor.blackTextColor(context).withOpacity(0.3),
              size: 55.sp,
            ),
          ),
          Gap(24.h),
          Text(
            'سلتك فارغة',
            style: AppTextStyle.titleMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.bold,
              fontSize: 22.sp,
            ),
          ),
          Gap(12.h),
          Text(
            'ابدأ بإضافة سيارات من قائمة السيارات',
            style: AppTextStyle.bodyMedium(
              context,
            ).copyWith(color: AppColor.blackTextColor(context).withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          Gap(32.h),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.primaryColor(context),
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
            ),
            child: Text(
              'تصفح السيارات',
              style: AppTextStyle.bodyMedium(
                context,
              ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
