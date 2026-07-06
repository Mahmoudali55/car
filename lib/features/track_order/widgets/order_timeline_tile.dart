import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/track_order/models/order_tracking_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart' hide StepState;

class OrderTimelineTile extends StatelessWidget {
  const OrderTimelineTile({super.key, required this.step, required this.isLast});

  final OrderStatusStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final color = _colorForState(step.state);
    final icon = _iconForState(step.state);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.16),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 16),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 54,
                color: Colors.grey.shade300,
                margin: const EdgeInsets.symmetric(vertical: 6),
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _localizedTitle(step.title, context),
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(
                  _localizedDescription(step.description, context),
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Color _colorForState(StepState state) {
    switch (state) {
      case StepState.done:
        return Colors.green;
      case StepState.active:
        return Colors.blueAccent;
      case StepState.pending:
        return Colors.grey;
    }
  }

  IconData _iconForState(StepState state) {
    switch (state) {
      case StepState.done:
        return Icons.check;
      case StepState.active:
        return Icons.autorenew;
      case StepState.pending:
        return Icons.hourglass_empty;
    }
  }

  String _localizedTitle(String title, BuildContext context) {
    switch (title) {
      case 'Order placed':
        return AppLocaleKey.statusOrderPlaced.tr();
      case 'Processing':
        return AppLocaleKey.statusProcessing.tr();
      case 'Ready':
        return AppLocaleKey.trackOrderReady.tr();
      default:
        return title.tr();
    }
  }

  String _localizedDescription(String description, BuildContext context) {
    switch (description) {
      case 'Your request has been received successfully.':
        return AppLocaleKey.trackOrderPlacedDescription.tr();
      case 'We are reviewing your request and preparing next steps.':
        return AppLocaleKey.trackOrderProcessingDescription.tr();
      case 'You will be notified once it is ready.':
        return AppLocaleKey.trackOrderReadyDescription.tr();
      default:
        return description.tr();
    }
  }
}
