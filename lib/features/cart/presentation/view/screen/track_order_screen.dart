import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for tracking orders
    final List<Map<String, dynamic>> activeOrders = [
      {
        'id': 'CAR-8821',
        'title': AppLocaleKey.mercedesSClass.tr(),
        'date': '28 March 2024',
        'status': AppLocaleKey.statusProcessing,
        'currentStep': 2, // 0: Placed, 1: Confirmed, 2: Processing, 3: Shipped, 4: Delivered
        'estDelivery': '05 Apr 2024',
      },
      {
        'id': 'CAR-9045',
        'title': AppLocaleKey.periodicMaintenance.tr(),
        'date': '30 March 2024',
        'status': AppLocaleKey.statusConfirmed,
        'currentStep': 1,
        'estDelivery': '02 Apr 2024',
      },
    ];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        title: Text(
          AppLocaleKey.trackOrder.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: activeOrders.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: activeOrders.length,
              itemBuilder: (context, index) {
                return FadeInUp(
                  delay: Duration(milliseconds: 100 * index),
                  child: _OrderTrackingCard(order: activeOrders[index]),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.local_shipping_outlined,
            size: 80.sp,
            color: AppColor.blackTextColor(context).withOpacity(0.1),
          ),
          Gap(16.h),
          Text(
            AppLocaleKey.noActiveOrders.tr(),
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context).withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderTrackingCard extends StatefulWidget {
  final Map<String, dynamic> order;
  const _OrderTrackingCard({required this.order});

  @override
  State<_OrderTrackingCard> createState() => _OrderTrackingCardState();
}

class _OrderTrackingCardState extends State<_OrderTrackingCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    final statusKey = widget.order['status'] as String;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: EdgeInsets.only(bottom: 20.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: _isExpanded 
              ? AppColor.primaryColor(context).withOpacity(0.3) 
              : baseColor.withOpacity(0.05),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 50.h,
                width: 50.h,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.inventory_2_outlined,
                  color: AppColor.primaryColor(context),
                  size: 24.sp,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.order['title'],
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: baseColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${AppLocaleKey.orderID.tr()}: ${widget.order['id']}",
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: baseColor.withOpacity(0.4),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              _StatusBadge(statusKey: statusKey),
            ],
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.estimatedDelivery.tr(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: baseColor.withOpacity(0.4),
                      fontSize: 10.sp,
                    ),
                  ),
                  Text(
                    widget.order['estDelivery'],
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: baseColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  backgroundColor: AppColor.primaryColor(context).withOpacity(0.05),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
                ),
                child: Row(
                  children: [
                    Text(
                      AppLocaleKey.viewTimeline.tr(),
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(4.w),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      size: 16.sp,
                      color: AppColor.primaryColor(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_isExpanded) ...[
            Gap(20.h),
            const Divider(),
            Gap(10.h),
            _buildTimeline(context),
          ],
        ],
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    final steps = [
      AppLocaleKey.statusOrderPlaced,
      AppLocaleKey.statusConfirmed,
      AppLocaleKey.statusProcessing,
      AppLocaleKey.statusShipped,
      AppLocaleKey.statusDelivered,
    ];
    final currentStep = widget.order['currentStep'] as int;

    return Column(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= currentStep;
        final isLast = index == steps.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: BoxDecoration(
                    color: isCompleted ? AppColor.primaryColor(context) : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isCompleted ? AppColor.primaryColor(context) : AppColor.blackTextColor(context).withOpacity(0.1),
                    ),
                  ),
                  child: isCompleted
                      ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                      : null,
                ),
                if (!isLast)
                  Container(
                    width: 2.w,
                    height: 30.h,
                    color: isCompleted ? AppColor.primaryColor(context) : AppColor.blackTextColor(context).withOpacity(0.1),
                  ),
              ],
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    steps[index].tr(),
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: isCompleted ? AppColor.blackTextColor(context) : AppColor.blackTextColor(context).withOpacity(0.3),
                      fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                  Gap(20.h),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String statusKey;
  const _StatusBadge({required this.statusKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.primaryColor(context).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        statusKey.tr(),
        style: AppTextStyle.bodySmall(context).copyWith(
          color: AppColor.primaryColor(context),
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
