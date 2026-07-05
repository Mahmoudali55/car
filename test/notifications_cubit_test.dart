import 'package:car/features/notifications/presentation/view/cubit/notifications_cubit.dart';
import 'package:car/features/notifications/presentation/view/cubit/notifications_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NotificationsCubit', () {
    test('adds a reservation created notification and increments unread count', () {
      final cubit = NotificationsCubit();

      cubit.addReservationNotification(
        title: 'تم الحجز بنجاح',
        body: 'تم حجز سيارة BMW بنجاح',
      );

      final state = cubit.state;
      expect(state, isA<NotificationsLoaded>());
      final loaded = state as NotificationsLoaded;
      expect(loaded.notifications.length, greaterThan(4));
      expect(loaded.unreadCount, greaterThan(0));
      expect(
        loaded.notifications.any((n) => n['title'] == 'تم الحجز بنجاح'),
        isTrue,
      );
    });

    test('adds a reservation reminder notification and increments unread count', () {
      final cubit = NotificationsCubit();

      cubit.addReservationNotification(
        title: 'الحجز قريب من الانتهاء',
        body: 'سيارة BMW ستنتهي صلاحية حجزها خلال ساعة',
      );

      final state = cubit.state;
      expect(state, isA<NotificationsLoaded>());
      final loaded = state as NotificationsLoaded;
      expect(loaded.notifications.length, greaterThan(4));
      expect(loaded.unreadCount, greaterThan(0));
      expect(
        loaded.notifications.any((n) => n['title'] == 'الحجز قريب من الانتهاء'),
        isTrue,
      );
    });
  });
}
