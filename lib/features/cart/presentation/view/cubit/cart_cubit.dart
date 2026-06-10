import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:car/core/cache/hive/hive_methods.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial()) {
    _loadCart();
  }

  void _loadCart() {
    final rawItems = HiveMethods.getCartItems();
    final List<Map<String, dynamic>> validItems = [];
    final now = DateTime.now();
    bool hasExpiredItems = false;

    for (var rawItem in rawItems) {
      final item = Map<String, dynamic>.from(rawItem as Map);
      if (item.containsKey('reservedAt')) {
        final reservedAt = DateTime.tryParse(item['reservedAt'].toString());
        if (reservedAt != null && now.difference(reservedAt).inHours < 24) {
          validItems.add(item);
        } else {
          hasExpiredItems = true;
        }
      } else {
        item['reservedAt'] = now.toIso8601String();
        validItems.add(item);
        hasExpiredItems = true; // Force save to persist the new timestamp
      }
    }

    if (hasExpiredItems) {
      HiveMethods.updateCartItems(validItems);
    }
    _updateCart(validItems);
  }

  void addToCart(Map<String, dynamic> car) {
    final updatedItems = List<Map<String, dynamic>>.from(state.items);

    // Check if item already exists based on name
    bool exists = updatedItems.any((item) => item['name'] == car['name']);

    if (!exists) {
      final carToAdd = Map<String, dynamic>.from(car);
      carToAdd['reservedAt'] = DateTime.now().toIso8601String();
      updatedItems.add(carToAdd);
      _updateCart(updatedItems);
      HiveMethods.updateCartItems(updatedItems);
    }
  }

  void removeFromCart(Map<String, dynamic> car) {
    final updatedItems = List<Map<String, dynamic>>.from(state.items);
    updatedItems.removeWhere((item) => item['name'] == car['name']);
    _updateCart(updatedItems);
    HiveMethods.updateCartItems(updatedItems);
  }

  void clearCart() {
    emit(CartState.initial());
    HiveMethods.updateCartItems([]);
  }

  void _updateCart(List<Map<String, dynamic>> items) {
    double total = 0.0;
    for (var item in items) {
      // Extract price from string like "850,000         "
      String priceStr = item['price'].toString().replaceAll(RegExp(r'[^0-9]'), '');
      total += double.tryParse(priceStr) ?? 0.0;
    }
    emit(state.copyWith(items: items, totalPrice: total));
  }

  bool isInCart(String carName) {
    return state.items.any((item) => item['name'] == carName);
  }
}
