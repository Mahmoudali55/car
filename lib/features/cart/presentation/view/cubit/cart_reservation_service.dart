import 'dart:async';

import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_model.dart';
import 'package:car/features/home/data/repository/home_repo.dart';
import 'package:flutter/foundation.dart';

/// Service that schedules a [Timer] per reserved car item.
/// When the 24-hour window expires the [HomeRepo.cancelreservedcar] endpoint
/// is called automatically, then [onExpired] is invoked so CartCubit can
/// refresh the list.
class CartReservationService {
  final HomeRepo homeRepo;

  CartReservationService({required this.homeRepo});

  // key → itemCode, value → active timer
  final Map<String, Timer> _timers = {};

  /// Schedule auto-cancellation for [car] using the typed [CarModel] directly.
  ///
  /// The car must have been reserved – we use [DateTime.now] as the reference
  /// point since the API does not return a reservedAt timestamp. If you store
  /// reservedAt separately, pass it via [reservedAt].
  void scheduleExpiryForModel({
    required CarModel car,
    required VoidCallback onExpired,
    DateTime? reservedAt,
  }) {
    final String key = car.itemCode ?? car.hashCode.toString();

    // Cancel any existing timer for the same item (idempotent).
    _timers[key]?.cancel();

    final DateTime from = reservedAt ?? DateTime.now();
    final DateTime expiryTime = from.add(const Duration(hours: 24));
    final Duration remaining = expiryTime.difference(DateTime.now());

    if (remaining <= Duration.zero) {
      // Already expired – fire immediately (async so we don't block callers).
      Future.microtask(() => _doCancelModel(car: car, onExpired: onExpired));
      return;
    }

    _timers[key] =
        Timer(remaining, () => _doCancelModel(car: car, onExpired: onExpired));

    if (kDebugMode) {
      debugPrint(
        '[CartReservationService] Scheduled cancel for $key '
        'in ${remaining.inMinutes} min ${remaining.inSeconds % 60} sec',
      );
    }
  }

  /// Cancel a pending timer without calling the endpoint.
  void cancelTimer(Map<String, dynamic> car) {
    final String key = car['itemCode']?.toString() ??
        car['name']?.toString() ??
        car.hashCode.toString();
    _timers[key]?.cancel();
    _timers.remove(key);
  }

  /// Cancel all pending timers (e.g., on logout / clear cart).
  void disposeAll() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
  }

  // ─── Private ─────────────────────────────────────────────────────────────

  Future<void> _doCancelModel({
    required CarModel car,
    required VoidCallback onExpired,
  }) async {
    final String key = car.itemCode ?? car.hashCode.toString();
    _timers.remove(key);

    final model = CancelReservedCarModel(
      lpoNo: car.lpoNo ?? '',
      itemCode: car.itemCode ?? '',
      storeCode: int.tryParse(car.storeCode?.toString() ?? '') ?? 0,
      notes: 'Auto-cancelled after 24h reservation window',
    );

    if (kDebugMode) {
      debugPrint(
        '[CartReservationService] Auto-cancelling ${model.itemCode} '
        '| lpoNo=${model.lpoNo} | storeCode=${model.storeCode}',
      );
    }

    await homeRepo.cancelreservedcar(model);

    // Notify the cubit regardless of API result.
    onExpired();
  }
}
