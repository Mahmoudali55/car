import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/cart/presentation/view/widget/cart_app_bar_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_empty_state_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_items_list_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_summary_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key, this.selectedCarId});

  final String? selectedCarId;
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    // Load reserved cars from API every time the screen opens.
    context.read<CartCubit>().loadReservedCars();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.isLoading != current.isLoading ||
          previous.cancellationMessage != current.cancellationMessage,
      listener: (context, state) {
        if (state.errorMessage != null) {
          CommonMethods.showToast(message: state.errorMessage!, type: ToastType.error);
        }

        if (state.isLoading == false) {
          context.read<CartCubit>().restoreTimers();
        }

        // رسالة النجاح اللي راجعة من الـ endpoint بعد إلغاء/حذف الحجز
        if (state.cancellationMessage != null) {
          CommonMethods.showToast(message: state.cancellationMessage!, type: ToastType.success);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          appBar: CartAppBarWidget(itemsCount: state.itemCount),
          body: state.isLoading
              ? const Center(child: CustomLoading())
              : state.reservedCars.isEmpty
              ? const CartEmptyStateWidget()
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 4.h),
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Colors.orange.withValues(alpha: 0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.info_outline_rounded,
                              size: 16.sp,
                              color: Colors.orange.shade800,
                            ),
                          ),
                          Gap(10.w),
                          Expanded(
                            child: Text(
                              AppLocaleKey.cancelReservationMsg.tr(),
                              style: AppTextStyle.bodySmall(context).copyWith(
                                color: Colors.orange.shade900,
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CartItemsListWidget(
                      cars: state.reservedCars,
                      selectedCarId: widget.selectedCarId,
                    ),
                    CartSummaryWidget(totalPrice: state.totalPrice),
                  ],
                ),
        );
      },
    );
  }
}
