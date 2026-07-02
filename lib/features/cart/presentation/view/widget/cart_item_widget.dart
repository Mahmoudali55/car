import 'dart:async';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatefulWidget {
  final CarModel car;

  const CartItemWidget({super.key, required this.car});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  bool _isCancelling = false;

  @override
  void initState() {
    super.initState();
    _calculateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _calculateTime());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateTime() {
    // reservedAt is not available directly from the API model.
    // The countdown is hidden until the backend returns a reservation timestamp.
    _remainingTime = Duration.zero;
    if (mounted) setState(() {});
  }

  // ─── Confirmation Dialog ────────────────────────────────────────────────

  Future<void> _onDeleteTapped() async {
    final cubit = context.read<CartCubit>();

    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => _CancelConfirmDialog(carName: widget.car.itemName ?? ''),
    );

    if (confirmed != true || !mounted) return;

    setState(() => _isCancelling = true);
    try {
      await cubit.cancelReservation(widget.car);
    } finally {
      if (mounted) setState(() => _isCancelling = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String carName = widget.car.itemName ?? '';
    final double price = widget.car.costPrice ?? 0;
    final String priceFormatted = price
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Countdown Timer ──────────────────────────────────────────────
          if (_remainingTime > Duration.zero) ...[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              margin: EdgeInsets.only(bottom: 12.h),
              decoration: BoxDecoration(
                color: AppColor.secondAppColor(context).withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: AppColor.iconColor(context)),
              ),
              child: Row(
                children: [
                  Icon(Icons.timer_outlined, color: AppColor.iconColor(context), size: 16.sp),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      ' ${AppLocaleKey.reservationDuration.tr()}  '
                      '${_remainingTime.inHours.toString().padLeft(2, '0')}${AppLocaleKey.hours.tr()}:'
                      '${(_remainingTime.inMinutes % 60).toString().padLeft(2, '0')} ${AppLocaleKey.minutes.tr()}:'
                      '${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')} ${AppLocaleKey.seconds.tr()}',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.iconColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // ── Car Row ──────────────────────────────────────────────────────
          Row(
            children: [
              // Car icon placeholder
              Container(
                width: 90.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: AppColor.scaffoldColor(context),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(
                  Icons.directions_car_rounded,
                  size: 36.sp,
                  color: AppColor.primaryColor(context).withValues(alpha: 0.4),
                ),
              ),
              Gap(14.w),

              // Car info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.car.chassisNo != null && widget.car.chassisNo!.isNotEmpty)
                      Text(
                        widget.car.chassisNo!,
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    Gap(4.h),
                    Text(
                      carName,
                      style: AppTextStyle.titleMedium(context).copyWith(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(6.h),
                    Text(
                      '$priceFormatted ${AppLocaleKey.sar.tr()}',
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Delete / Cancel button ─────────────────────────────────
              GestureDetector(
                onTap: _isCancelling ? null : _onDeleteTapped,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColor.redColor(context)
                        .withValues(alpha: _isCancelling ? 0.05 : 0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _isCancelling
                      ? SizedBox(
                          width: 22.sp,
                          height: 22.sp,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(AppColor.redColor(context)),
                          ),
                        )
                      : Icon(
                          Icons.delete_outline_rounded,
                          color: AppColor.redColor(context),
                          size: 22.sp,
                        ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Confirmation Dialog ────────────────────────────────────────────────────

class _CancelConfirmDialog extends StatelessWidget {
  final String carName;
  const _CancelConfirmDialog({required this.carName});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
      backgroundColor: AppColor.scaffoldColor(context),
      child: Padding(
        padding: EdgeInsets.fromLTRB(24.w, 28.h, 24.w, 20.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Warning icon
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: AppColor.redColor(context).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: AppColor.redColor(context),
                size: 32.sp,
              ),
            ),
            Gap(16.h),

            // Title
            Text(
              AppLocaleKey.cancelReservationTitle.tr(),
              style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            Gap(10.h),

            // Body
            Text(
              AppLocaleKey.cancelReservationBody.tr(),
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            Gap(24.h),

            // Action buttons
            Row(
              children: [
                // No — keep reservation
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      side: BorderSide(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      AppLocaleKey.cancelReservationNo.tr(),
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
                Gap(12.w),

                // Yes — cancel reservation
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.redColor(context),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                    ),
                    child: Text(
                      AppLocaleKey.cancelReservationYes.tr(),
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
