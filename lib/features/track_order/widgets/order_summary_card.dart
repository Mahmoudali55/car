import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/track_order/models/order_tracking_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OrderSummaryCard extends StatelessWidget {
  const OrderSummaryCard({super.key, required this.order});

  final OrderTracking order;

  @override
  Widget build(BuildContext context) {
    final typeLabel = _typeLabel(order.type);
    final badgeColor = _badgeColor(order.type);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  typeLabel,
                  style: AppTextStyle.bodySmall(
                    context,
                    color: badgeColor,
                  ).copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const Spacer(),
              Text(
                order.referenceNumber,
                style: AppTextStyle.bodySmall(context, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(order.title, style: AppTextStyle.titleLarge(context)),
          const SizedBox(height: 6),
          Text(
            order.subtitle,
            style: AppTextStyle.bodyMedium(context, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _InfoChip(icon: Icons.calendar_today_outlined, label: order.orderDate),
              const SizedBox(width: 8),
              _InfoChip(icon: Icons.tag_outlined, label: order.orderId),
            ],
          ),
        ],
      ),
    );
  }

  String _typeLabel(OrderType type) {
    switch (type) {
      case OrderType.financing:
        return AppLocaleKey.trackOrderFinancing.tr();
      case OrderType.purchase:
        return AppLocaleKey.trackOrderPurchase.tr();
      case OrderType.service:
        return AppLocaleKey.trackOrderService.tr();
    }
  }

  Color _badgeColor(OrderType type) {
    switch (type) {
      case OrderType.financing:
        return Colors.blueAccent;
      case OrderType.purchase:
        return Colors.teal;
      case OrderType.service:
        return Colors.orangeAccent;
    }
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.bodySmall(context),
            ),
          ),
        ],
      ),
    );
  }
}
