import 'package:car/features/track_order/models/order_tracking_model.dart';
import 'package:equatable/equatable.dart';

abstract class TrackOrderState extends Equatable {
  const TrackOrderState();

  @override
  List<Object?> get props => [];
}

class TrackOrderInitial extends TrackOrderState {}

class TrackOrderLoading extends TrackOrderState {}

class TrackOrderLoaded extends TrackOrderState {
  const TrackOrderLoaded({required this.order});

  final OrderTracking order;

  @override
  List<Object?> get props => [order];
}

class TrackOrderEmpty extends TrackOrderState {}

class TrackOrderError extends TrackOrderState {
  const TrackOrderError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class TrackOrderCancelling extends TrackOrderState {}
