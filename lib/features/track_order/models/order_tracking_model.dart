import 'package:equatable/equatable.dart';

enum OrderType { financing, purchase, service }

enum StepState { done, active, pending }

class OrderStatusStep extends Equatable {
  const OrderStatusStep({required this.title, required this.description, required this.state});

  final String title;
  final String description;
  final StepState state;

  @override
  List<Object?> get props => [title, description, state];
}

class OrderTracking extends Equatable {
  const OrderTracking({
    required this.orderId,
    required this.referenceNumber,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.orderDate,
    required this.isCancellable,
    required this.steps,
  });

  final String orderId;
  final String referenceNumber;
  final OrderType type;
  final String title;
  final String subtitle;
  final String orderDate;
  final bool isCancellable;
  final List<OrderStatusStep> steps;

  @override
  List<Object?> get props => [
    orderId,
    referenceNumber,
    type,
    title,
    subtitle,
    orderDate,
    isCancellable,
    steps,
  ];
}
