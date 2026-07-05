import 'dart:async';

import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/services/notification_service.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_model.dart';
import 'package:car/features/home/data/repository/home_repo.dart';
import 'package:flutter/foundation.dart';

/// Service that schedules a [Timer] per reserved car item.
/// When the reservation window expires the [HomeRepo.cancelreservedcar]
/// endpoint is called automatically, then [onExpired] is invoked so
/// CartCubit can refresh the list.
class CartReservationService {
  final HomeRepo homeRepo;

  CartReservationService({required this.homeRepo});

  static const Duration reservationWindow = Duration(hours: 24);

  // key → itemCode, value → active timer
  final Map<String, Timer> _timers = {};

  // key → itemCode, value → reminder timer scheduled one hour before expiry.
  final Map<String, Timer> _reminderTimers = {};

  // key → itemCode, value → whether the reminder notification has already been sent.
  final Set<String> _reminderSent = <String>{};

  // key → itemCode, value → the DateTime this reservation expires at.
  // Exposed so the UI can compute a live countdown instead of guessing.
  final Map<String, DateTime> _expiryTimes = {};

  // key → itemCode, value → the DateTime this reservation started at.
  final Map<String, DateTime> _reservationStarts = {};

  /// Returns the expiry [DateTime] for [itemCode], or null if there is no
  /// active timer for it (e.g. not reserved, or already expired/cancelled).
  DateTime? expiryTimeFor(String itemCode) => _expiryTimes[itemCode];

  /// Remember the first reservation timestamp for [car].
  void rememberReservationStart(CarModel car, {DateTime? reservedAt}) {
    final String key = car.itemCode ?? car.hashCode.toString();
    final DateTime startTime = reservedAt ?? DateTime.now();
    _reservationStarts[key] = startTime;
    HiveMethods.updateReservationStartedAt(key, startTime);
  }

  /// Schedule auto-cancellation for [car] using the typed [CarModel] directly.
  ///
  /// The timer uses the first reservation timestamp if it was previously saved;
  /// otherwise it falls back to the provided [reservedAt] or [DateTime.now].
  void scheduleExpiryForModel({
    required CarModel car,
    required VoidCallback onExpired,
    DateTime? reservedAt,
  }) {
    final String key = car.itemCode ?? car.hashCode.toString();

    // Cancel any existing timer for the same item (idempotent).
    _timers[key]?.cancel();
    _reminderTimers[key]?.cancel();

    final DateTime? storedStart = _reservationStarts[key] ?? _readStoredStartTime(key);
    final DateTime from = reservedAt ?? storedStart ?? DateTime.now();
    if (storedStart == null) {
      _reservationStarts[key] = from;
      HiveMethods.updateReservationStartedAt(key, from);
    }

    final DateTime expiryTime = from.add(reservationWindow);
    final Duration remaining = expiryTime.difference(DateTime.now());

    _expiryTimes[key] = expiryTime;

    if (remaining > const Duration(hours: 1)) {
      final Duration reminderDelay = remaining - const Duration(minutes: 5);
      _reminderTimers[key] = Timer(reminderDelay, () {
        if (_reminderSent.add(key)) {
          NotificationService.showReservationReminder(carName: car.itemName ?? 'السيارة');
        }
      });
    } else if (remaining > Duration.zero && _reminderSent.add(key)) {
      NotificationService.showReservationReminder(carName: car.itemName ?? 'السيارة');
    }

    if (remaining <= Duration.zero) {
      // Already expired – fire immediately (async so we don't block callers).
      Future.microtask(() => _doCancelModel(car: car, onExpired: onExpired));
      return;
    }

    _timers[key] = Timer(remaining, () => _doCancelModel(car: car, onExpired: onExpired));

    if (kDebugMode) {
      debugPrint(
        '[CartReservationService] Scheduled cancel for $key '
        'in ${remaining.inMinutes} min ${remaining.inSeconds % 60} sec',
      );
    }
  }

  /// Cancel a pending timer without calling the endpoint.
  void cancelTimer(Map<String, dynamic> car) {
    final String key =
        car['itemCode']?.toString() ?? car['name']?.toString() ?? car.hashCode.toString();
    _timers[key]?.cancel();
    _reminderTimers[key]?.cancel();
    _timers.remove(key);
    _reminderTimers.remove(key);
    _expiryTimes.remove(key);
    _reservationStarts.remove(key);
    _reminderSent.remove(key);
    HiveMethods.clearReservationStartedAt(key);
  }

  /// Cancel all pending timers (e.g., on logout / clear cart).
  void disposeAll() {
    for (final timer in _timers.values) {
      timer.cancel();
    }
    _timers.clear();
    _reminderTimers.clear();
    _expiryTimes.clear();
    _reservationStarts.clear();
    _reminderSent.clear();
  }

  // ─── Private ─────────────────────────────────────────────────────────────

  DateTime? _readStoredStartTime(String key) {
    final String? stored = HiveMethods.getReservationStartedAt(key);
    if (stored == null || stored.isEmpty) return null;
    return DateTime.tryParse(stored);
  }

  Future<void> _doCancelModel({required CarModel car, required VoidCallback onExpired}) async {
    final String key = car.itemCode ?? car.hashCode.toString();
    _timers.remove(key);
    _reminderTimers.remove(key);
    _expiryTimes.remove(key);
    _reservationStarts.remove(key);
    _reminderSent.remove(key);
    HiveMethods.clearReservationStartedAt(key);

    final model = CancelReservedCarModel(
      lpoNo: car.lpoNo ?? '',
      itemCode: car.itemCode ?? '',
      storeCode: int.tryParse(car.storeCode?.toString() ?? '') ?? 0,
      notes: 'Auto-cancelled after reservation window expired',
    );

    if (kDebugMode) {
      debugPrint(
        '[CartReservationService] Auto-cancelling ${model.itemCode} '
        '| lpoNo=${model.lpoNo} | storeCode=${model.storeCode}',
      );
    }

    await homeRepo.cancelreservedcar(model);

    unawaited(
      NotificationService.showReservationCancelledNotification(carName: car.itemName ?? 'السيارة'),
    );

    // Notify the cubit regardless of API result.
    onExpired();
  }
}
