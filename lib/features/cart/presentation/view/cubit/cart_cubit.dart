import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  void addToCart(Map<String, dynamic> car) {
    final updatedItems = List<Map<String, dynamic>>.from(state.items);
    
    // Check if item already exists based on name
    bool exists = updatedItems.any((item) => item['name'] == car['name']);
    
    if (!exists) {
      updatedItems.add(car);
      _updateCart(updatedItems);
    }
  }

  void removeFromCart(Map<String, dynamic> car) {
    final updatedItems = List<Map<String, dynamic>>.from(state.items);
    updatedItems.removeWhere((item) => item['name'] == car['name']);
    _updateCart(updatedItems);
  }

  void clearCart() {
    emit(CartState.initial());
  }

  void _updateCart(List<Map<String, dynamic>> items) {
    double total = 0.0;
    for (var item in items) {
      // Extract price from string like "850,000 د.إ"
      String priceStr = item['price'].toString().replaceAll(RegExp(r'[^0-9]'), '');
      total += double.tryParse(priceStr) ?? 0.0;
    }
    emit(state.copyWith(items: items, totalPrice: total));
  }

  bool isInCart(String carName) {
    return state.items.any((item) => item['name'] == carName);
  }
}
