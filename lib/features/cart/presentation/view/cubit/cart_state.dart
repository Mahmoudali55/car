part of 'cart_cubit.dart';

class CartState {
  /// Cars retrieved from the API (carstatus=2 = reserved).
  final List<admin.CarModel> reservedCars;

  final bool isLoading;
  final String? errorMessage;

  /// Set to the API success message after a cancellation completes.
  /// Consumed by the UI as a one-shot SnackBar trigger, then cleared.
  final String? cancellationMessage;

  const CartState({
    this.reservedCars = const [],
    this.isLoading = false,
    this.errorMessage,
    this.cancellationMessage,
  });

  factory CartState.initial() {
    return const CartState();
  }

  CartState copyWith({
    List<admin.CarModel>? reservedCars,
    bool? isLoading,
    String? errorMessage,
    String? cancellationMessage,
  }) {
    return CartState(
      reservedCars: reservedCars ?? this.reservedCars,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      cancellationMessage: cancellationMessage,
    );
  }

  /// Total price computed from API car data.
  double get totalPrice {
    double total = 0.0;
    for (final car in reservedCars) {
      total += car.costPrice ?? 0.0;
    }
    return total;
  }

  int get itemCount => reservedCars.length;
}
