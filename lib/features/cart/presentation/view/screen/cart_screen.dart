import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/cart/presentation/view/widget/cart_app_bar_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_empty_state_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_items_list_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_summary_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
          appBar: CartAppBarWidget(itemsCount: items.length),
          body: items.isEmpty
              ? const CartEmptyStateWidget()
              : Column(
                  children: [
                    CartItemsListWidget(items: items),
                    CartSummaryWidget(totalPrice: totalPrice),
                  ],
                ),
        );
      },
    );
  }
}
