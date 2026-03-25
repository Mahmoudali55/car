part of 'cart_cubit.dart';

class CartState {
  final List<Map<String, dynamic>> items;
  final double totalPrice;

  CartState({required this.items, required this.totalPrice});

  factory CartState.initial() {
    return CartState(items: [], totalPrice: 0.0);
  }

  CartState copyWith({List<Map<String, dynamic>>? items, double? totalPrice}) {
    return CartState(
      items: items ?? this.items,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
