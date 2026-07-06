import 'package:car/features/track_order/models/order_tracking_model.dart';

abstract class TrackOrderRepository {
  Future<OrderTracking> getTracking(String orderId);
  Future<void> cancelOrder(String orderId);
}

class TrackOrderRepositoryImpl implements TrackOrderRepository {
  TrackOrderRepositoryImpl({this.baseUrl = 'https://delta-asg.com'});

  final String baseUrl;

  @override
  Future<OrderTracking> getTracking(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 900));

    // TODO: Replace with real API call once backend is ready.
    // Example:
    // final response = await Dio().get('$baseUrl/api/orders/$orderId/tracking');
    // return OrderTracking.fromJson(response.data);

    return _mockTracking(orderId);
  }

  @override
  Future<void> cancelOrder(String orderId) async {
    await Future.delayed(const Duration(milliseconds: 700));

    // TODO: Replace with real API call once backend is ready.
    // Example:
    // await Dio().post('$baseUrl/api/orders/$orderId/cancel');

    if (orderId.isEmpty) {
      throw Exception('Order id is required');
    }
  }

  OrderTracking _mockTracking(String orderId) {
    final orderType = orderId.contains('FIN')
        ? OrderType.financing
        : orderId.contains('SRV')
        ? OrderType.service
        : OrderType.purchase;

    return OrderTracking(
      orderId: orderId,
      referenceNumber: '#${orderId.toUpperCase()}',
      type: orderType,
      title: _titleForType(orderType),
      subtitle: _subtitleForType(orderType),
      orderDate: 'June 28, 2026',
      isCancellable: true,
      steps: [
        const OrderStatusStep(
          title: 'Order placed',
          description: 'Your request has been received successfully.',
          state: StepState.done,
        ),
        const OrderStatusStep(
          title: 'Processing',
          description: 'We are reviewing your request and preparing next steps.',
          state: StepState.active,
        ),
        const OrderStatusStep(
          title: 'Ready',
          description: 'You will be notified once it is ready.',
          state: StepState.pending,
        ),
      ],
    );
  }

  String _titleForType(OrderType type) {
    switch (type) {
      case OrderType.financing:
        return 'Financing application';
      case OrderType.purchase:
        return 'Vehicle purchase';
      case OrderType.service:
        return 'Service request';
    }
  }

  String _subtitleForType(OrderType type) {
    switch (type) {
      case OrderType.financing:
        return 'Your financing request is being reviewed.';
      case OrderType.purchase:
        return 'Your purchase is progressing smoothly.';
      case OrderType.service:
        return 'Your service request is in progress.';
    }
  }
}
