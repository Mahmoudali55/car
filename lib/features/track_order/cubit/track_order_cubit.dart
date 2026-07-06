import 'package:bloc/bloc.dart';
import 'package:car/features/track_order/cubit/track_order_state.dart';
import 'package:car/features/track_order/repository/track_order_repository.dart';

class TrackOrderCubit extends Cubit<TrackOrderState> {
  TrackOrderCubit({required TrackOrderRepository repository})
    : _repository = repository,
      super(TrackOrderInitial());

  final TrackOrderRepository _repository;

  Future<void> loadTracking(String orderId) async {
    if (orderId.trim().isEmpty) {
      emit(const TrackOrderError(message: 'Order ID is required.'));
      return;
    }

    emit(TrackOrderLoading());

    try {
      final order = await _repository.getTracking(orderId);
      if (order.steps.isEmpty) {
        emit(TrackOrderEmpty());
      } else {
        emit(TrackOrderLoaded(order: order));
      }
    } catch (e) {
      emit(TrackOrderError(message: e.toString()));
    }
  }

  Future<void> cancelOrder(String orderId) async {
    if (orderId.trim().isEmpty) {
      emit(const TrackOrderError(message: 'Order ID is required.'));
      return;
    }

    emit(TrackOrderCancelling());

    try {
      await _repository.cancelOrder(orderId);
      await loadTracking(orderId);
    } catch (e) {
      emit(TrackOrderError(message: e.toString()));
    }
  }
}
