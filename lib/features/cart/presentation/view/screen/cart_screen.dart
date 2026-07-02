import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:car/features/cart/presentation/view/widget/cart_app_bar_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_empty_state_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_items_list_widget.dart';
import 'package:car/features/cart/presentation/view/widget/cart_summary_widget.dart';
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
    return BlocBuilder<CartCubit, CartState>(
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
                        CartItemsListWidget(cars: state.reservedCars),
                        CartSummaryWidget(totalPrice: state.totalPrice),
                      ],
                    ),
        );
      },
    );
  }
}
