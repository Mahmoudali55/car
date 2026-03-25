import 'package:flutter_bloc/flutter_bloc.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial()) {
    loadNotifications();
  }

  void loadNotifications() {
    // Dummy Data for notifications
    final List<Map<String, dynamic>> dummyNotifications = [
      {
        'id': '1',
        'title': 'عرض جديد! 🏎️',
        'body': 'احصل على خصم 10% على صيانة سيارتك البي إم دبليو هذا الأسبوع.',
        'time': 'منذ دقيقتين',
        'isRead': false,
        'type': 'offer',
      },
      {
        'id': '2',
        'title': 'تم تأكيد طلبك ✅',
        'body': 'طلبك رقم #CAR-1234 تم تأكيده وسيتصل بك المندوب قريباً.',
        'time': 'منذ ساعة',
        'isRead': false,
        'type': 'order',
      },
      {
        'id': '3',
        'title': 'تحديث النظام ⚙️',
        'body': 'قمت بإضافة ميزة السلة والدفع بنجاح. استمتع بالتجربة الجديدة!',
        'time': 'منذ 3 ساعات',
        'isRead': true,
        'type': 'system',
      },
      {
        'id': '4',
        'title': 'سيارة جديدة مضافة حديثاً 🌟',
        'body': 'مرسيدس G-Class 2024 متوفرة الآن في المعرض.',
        'time': 'أمس',
        'isRead': true,
        'type': 'offer',
      },
    ];

    _emitLoaded(dummyNotifications);
  }

  void markAsRead(String id) {
    if (state is NotificationsLoaded) {
      final currentState = state as NotificationsLoaded;
      final updatedList = currentState.notifications.map((n) {
        if (n['id'] == id) {
          return {...n, 'isRead': true};
        }
        return n;
      }).toList();
      _emitLoaded(updatedList);
    }
  }

  void markAllAsRead() {
    if (state is NotificationsLoaded) {
      final currentState = state as NotificationsLoaded;
      final updatedList = currentState.notifications.map((n) {
        return {...n, 'isRead': true};
      }).toList();
      _emitLoaded(updatedList);
    }
  }

  void clearAll() {
    _emitLoaded([]);
  }

  void _emitLoaded(List<Map<String, dynamic>> list) {
    final unreadCount = list.where((n) => n['isRead'] == false).length;
    emit(NotificationsLoaded(notifications: list, unreadCount: unreadCount));
  }
}
