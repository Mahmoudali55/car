import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/features/track_order/cubit/track_order_cubit.dart';
import 'package:car/features/track_order/cubit/track_order_state.dart';
import 'package:car/features/track_order/repository/track_order_repository.dart';
import 'package:car/features/track_order/widgets/order_summary_card.dart';
import 'package:car/features/track_order/widgets/order_timeline_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key, this.orderId = 'ORD-1001'});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrackOrderCubit(repository: TrackOrderRepositoryImpl())..loadTracking(orderId),
      child: _TrackOrderView(orderId: orderId),
    );
  }
}

class _TrackOrderView extends StatelessWidget {
  const _TrackOrderView({required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.trackOrder.tr())),
      body: BlocConsumer<TrackOrderCubit, TrackOrderState>(
        listener: (context, state) {
          if (state is TrackOrderError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () => context.read<TrackOrderCubit>().loadTracking(orderId),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                if (state is TrackOrderLoading || state is TrackOrderInitial)
                  const Center(
                    child: Padding(padding: EdgeInsets.all(32), child: CircularProgressIndicator()),
                  )
                else if (state is TrackOrderLoaded)
                  _buildLoadedState(context, state)
                else if (state is TrackOrderEmpty)
                  _buildEmptyState(context)
                else if (state is TrackOrderCancelling)
                  _buildCancellingState(context)
                else if (state is TrackOrderError)
                  _buildErrorState(context, state.message),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLoadedState(BuildContext context, TrackOrderLoaded state) {
    final order = state.order;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OrderSummaryCard(order: order),
        const SizedBox(height: 20),
        Text(
          AppLocaleKey.viewTimeline.tr(),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Theme.of(context).dividerColor.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              for (int index = 0; index < order.steps.length; index++)
                OrderTimelineTile(
                  step: order.steps[index],
                  isLast: index == order.steps.length - 1,
                ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(RoutesName.supportScreen);
                },
                icon: const Icon(Icons.support_agent_outlined),
                label: Text(AppLocaleKey.trackOrderContactSupport.tr()),
              ),
            ),
            const SizedBox(width: 12),
            if (order.isCancellable)
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () => _showCancelDialog(context, order.orderId),
                  icon: const Icon(Icons.cancel_outlined),
                  label: Text(AppLocaleKey.trackOrderCancelOrder.tr()),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            const Icon(Icons.inbox_outlined, size: 56),
            const SizedBox(height: 12),
            Text(AppLocaleKey.trackOrderNoDetails.tr()),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => context.read<TrackOrderCubit>().loadTracking(orderId),
              child: Text(AppLocaleKey.trackOrderRetry.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancellingState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Text(AppLocaleKey.trackOrderCancelling.tr()),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48),
        child: Column(
          children: [
            const Icon(Icons.error_outline, size: 56),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => context.read<TrackOrderCubit>().loadTracking(orderId),
              child: Text(AppLocaleKey.trackOrderRetry.tr()),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCancelDialog(BuildContext context, String orderId) async {
    final shouldCancel = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocaleKey.trackOrderCancelOrderTitle.tr()),
        content: Text(AppLocaleKey.trackOrderCancelOrderMessage.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(AppLocaleKey.trackOrderNo.tr()),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(AppLocaleKey.trackOrderYesCancel.tr()),
          ),
        ],
      ),
    );

    if (shouldCancel == true) {
      if (!context.mounted) return;
      await context.read<TrackOrderCubit>().cancelOrder(orderId);
    }
  }
}
