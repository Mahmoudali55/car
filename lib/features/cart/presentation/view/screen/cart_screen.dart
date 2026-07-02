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

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

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
              ? const Center(child: CircularProgressIndicator())
              : state.reservedCars.isEmpty
              ? const CartEmptyStateWidget()
              : Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.orange.withValues(alpha: 0.35)),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_amber_rounded,
                            size: 18,
                            color: Colors.orange.shade700,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              AppLocaleKey.cancelReservationMsg.tr(),
                              style: AppTextStyle.bodyMedium(context).copyWith(
                                color: Colors.orange.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    CartItemsListWidget(cars: state.reservedCars),
                    CartSummaryWidget(totalPrice: state.totalPrice),
                  ],
                ),
        );
      },
    );
  }
}
