import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsInitial()) {
    loadNotifications();
  }

  void loadNotifications() {
    emit(NotificationsLoading());
    // Real data is loaded via HomeCubit.getNotificationsData
    // and then fed in via loadFromApi(). This initial call is a
    // placeholder that shows a loading state until data arrives.
  }

  /// Called externally (e.g., from a BlocListener) once HomeCubit
  /// returns the real notifications from the server.
  void loadFromApi(List<Map<String, dynamic>> notifications) {
    _emitLoaded(notifications.where((notification) => notification['isRead'] != true).toList());
  }

  void addReservationNotification({required String title, required String body}) {
    final notification = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'title': title,
      'body': body,
      'time': 'الآن',
      'isRead': false,
      'type': 'reservation',
    };

    if (state is NotificationsLoaded) {
      final currentState = state as NotificationsLoaded;
      _emitLoaded([notification, ...currentState.notifications]);
    } else {
      _emitLoaded([notification]);
    }
  }

  void markAsRead(String id) {
    if (state is NotificationsLoaded) {
      final currentState = state as NotificationsLoaded;
      final updatedList = currentState.notifications.map((n) {
        if (n['id'] == id) return {...n, 'isRead': true};
        return n;
      }).toList();
      _emitLoaded(updatedList);
    }
  }

  void markAllAsRead() {
    if (state is NotificationsLoaded) {
      final currentState = state as NotificationsLoaded;
      final updatedList = currentState.notifications.map((n) => {...n, 'isRead': true}).toList();
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

  /// Convenience: triggers HomeCubit to fetch and then feeds data here.
  static void fetchAndLoad(HomeCubit homeCubit) {
    final code = HiveMethods.getcode() ?? '';
    final isAgent = HiveMethods.isAgentRole();
    homeCubit.getNotificationsData(currentUserId: code, userType: isAgent ? 2 : 1);
  }
}
