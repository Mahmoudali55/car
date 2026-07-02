import 'dart:async';

import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart' as admin;
import 'package:car/features/admin/data/repo/admin_repo.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_reservation_service.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_model.dart';
import 'package:car/features/home/data/repository/home_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final AdminRepo adminRepo;
  final HomeRepo homeRepo;
  late final CartReservationService _reservationService;

  CartCubit({required this.adminRepo, required this.homeRepo}) : super(CartState.initial()) {
    _reservationService = CartReservationService(homeRepo: homeRepo);
  }

  // ─── Load reserved cars from API (carstatus=2, CUSTOMER_NO=userCode) ────

  Future<void> loadReservedCars() async {
    final String? userCodeStr = HiveMethods.getUserCode();
    final int? customerNo = int.tryParse('5');

    emit(state.copyWith(isLoading: true, errorMessage: null));

    final result = await adminRepo.getCars(2, customerNo);

    result.fold(
      (failure) {
        emit(state.copyWith(isLoading: false, errorMessage: failure.errMessage));
      },
      (carsModel) {
        final cars = carsModel.data;
        _scheduleAllTimers(cars);
        emit(state.copyWith(isLoading: false, reservedCars: cars));
      },
    );
  }

  // ─── Cancel reservation: calls endpoint then removes locally ────────────
  // All required fields (lpoNo, storeCode) are taken directly from the CarModel.
  // No Hive map lookups needed.

  Future<void> cancelReservation(admin.CarModel car) async {
    final String lpoNo = car.lpoNo ?? '';
    final int storeCode = int.tryParse(car.storeCode?.toString() ?? '') ?? 0;

    final model = CancelReservedCarModel(
      lpoNo: lpoNo,
      itemCode: car.itemCode ?? '',
      storeCode: storeCode,
      notes: 'Cancelled by user',
    );

    if (kDebugMode) {
      debugPrint(
        '[CartCubit] Calling cancelReservedCar for ${car.itemCode} '
        '| lpoNo=$lpoNo | storeCode=$storeCode',
      );
    }

    final result = await homeRepo.cancelreservedcar(model);

    result.fold(
      (failure) {
        if (kDebugMode) {
          debugPrint('[CartCubit] cancelReservation failed: ${failure.errMessage}');
        }
      },
      (response) {
        if (kDebugMode) {
          debugPrint('[CartCubit] cancelReservation success: ${response.msg}');
        }
      },
    );

    // Stop the auto-cancel timer for this car.
    _reservationService.cancelTimer({'itemCode': car.itemCode});

    // Refresh from API.
    if (!isClosed) unawaited(loadReservedCars());
  }

  // ─── Remove locally only (no endpoint – e.g., after auto-cancel) ─────────

  void removeFromCart(admin.CarModel car) {
    _reservationService.cancelTimer({'itemCode': car.itemCode, 'name': car.itemName});

    // Refresh the reserved-cars list from API.
    unawaited(loadReservedCars());
  }

  // ─── Clear all ───────────────────────────────────────────────────────────

  void clearCart() {
    _reservationService.disposeAll();
    emit(CartState.initial());
  }

  // ─── Restore timers after app restart ────────────────────────────────────
  // Now uses the API data (reservedCars) as the source of truth instead of Hive maps.

  void restoreTimers() {
    _scheduleAllTimers(state.reservedCars);
  }

  // ─── Called when timer fires after 24h ───────────────────────────────────

  void _onItemExpired(admin.CarModel car) {
    if (kDebugMode) {
      debugPrint('[CartCubit] Item expired, removing from cart: ${car.itemCode}');
    }

    // Refresh the reserved-cars list from API.
    if (!isClosed) {
      unawaited(loadReservedCars());
    }
  }

  // ─── Schedule timers for all currently loaded cars ────────────────────────

  void _scheduleAllTimers(List<admin.CarModel> cars) {
    for (final car in cars) {
      _reservationService.scheduleExpiryForModel(car: car, onExpired: () => _onItemExpired(car));
    }
  }

  @override
  Future<void> close() {
    _reservationService.disposeAll();
    return super.close();
  }

  // ─── Helper ──────────────────────────────────────────────────────────────

  bool isInCart(String itemCode) {
    return state.reservedCars.any((c) => c.itemCode == itemCode);
  }
}
