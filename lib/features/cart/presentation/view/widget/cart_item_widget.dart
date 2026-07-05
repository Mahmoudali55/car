import 'dart:async';

import 'package:car/core/custom_widgets/custom_sar_text.dart';
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

class _CartItemWidgetState extends State<CartItemWidget> with SingleTickerProviderStateMixin {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;
  bool _isCancelling = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // نحسب أول قيمة فورًا بعد أول frame عشان نضمن إن context.read<CartCubit>()
    // متاح والـ CartReservationService خلّصت تسجيل التايمرز (scheduleExpiryForModel).
    WidgetsBinding.instance.addPostFrameCallback((_) => _calculateTime());
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _calculateTime());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    _animationController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  void _calculateTime() {
    if (!mounted) return;

    final DateTime? expiry = context.read<CartCubit>().expiryTimeFor(widget.car.itemCode);

    if (expiry == null) {
      setState(() => _remainingTime = Duration.zero);
      return;
    }

    final Duration diff = expiry.difference(DateTime.now());
    setState(() => _remainingTime = diff.isNegative ? Duration.zero : diff);
  }

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
    final bool isAboutToExpire = _remainingTime > Duration.zero && _remainingTime <= const Duration(hours: 1);
    final String priceFormatted = price
        .toStringAsFixed(0)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},');

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.3, 0),
          end: Offset.zero,
        ).animate(_fadeAnimation),
        child: Container(
          margin: EdgeInsets.only(bottom: 14.h),
          decoration: BoxDecoration(
            color: AppColor.scaffoldColor(context),
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // ─── Top Section ──────────────────────────────────
              Container(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    // Car Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Container(
                        width: 72.w,
                        height: 72.w,
                        color: AppColor.primaryColor(context).withValues(alpha: 0.06),
                        child: Center(
                          child: Icon(
                            Icons.directions_car_rounded,
                            size: 36.sp,
                            color: AppColor.primaryColor(context).withValues(alpha: 0.25),
                          ),
                        ),
                      ),
                    ),
                    Gap(14.w),
                    // Car Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor(context).withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child:
                                    (widget.car.chassisNo != null &&
                                        widget.car.chassisNo!.isNotEmpty)
                                    ? Text(
                                        '${widget.car.chassisNo!}',
                                        style: AppTextStyle.bodySmall(
                                          context,
                                        ).copyWith(color: AppColor.primaryColor(context)),
                                      )
                                    : Gap(0),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: AppColor.primaryColor(context).withValues(alpha: 0.08),
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  AppLocaleKey.active.tr(),
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    color: AppColor.primaryColor(context),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 10.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(6.h),
                          Text(
                            carName,
                            style: AppTextStyle.titleMedium(context).copyWith(
                              fontWeight: FontWeight.w700,
                              fontSize: 15.sp,
                              color: AppColor.blackTextColor(context),
                            ),
                          ),

                          Gap(6.h),
                          Row(
                            children: [
                              ValueWithCurrencyIcon(
                                text: '$priceFormatted  ${AppLocaleKey.sar.tr()}',
                                textStyle: AppTextStyle.titleMedium(context).copyWith(
                                  color: AppColor.primaryColor(context),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 17.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Status Badge
                  ],
                ),
              ),

              // ─── Divider ──────────────────────────────────────
              Container(
                height: 1,
                color: AppColor.blackTextColor(context).withValues(alpha: 0.05),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
              ),

              // ─── Bottom Section ──────────────────────────────
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  children: [
                    // Timer
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time_rounded,
                                size: 16.sp,
                                color: isAboutToExpire
                                    ? Colors.orange.shade700
                                    : _remainingTime <= const Duration(seconds: 30)
                                    ? AppColor.redColor(context)
                                    : AppColor.blackTextColor(context).withValues(alpha: 0.35),
                              ),
                              Gap(6.w),
                              Text(
                                '${_remainingTime.inHours.toString().padLeft(2, '0')}:${(_remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')}',
                                style: AppTextStyle.bodySmall(context).copyWith(
                                  color: isAboutToExpire
                                      ? Colors.orange.shade700
                                      : _remainingTime <= const Duration(seconds: 30)
                                      ? AppColor.redColor(context)
                                      : AppColor.blackTextColor(context).withValues(alpha: 0.5),
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                          if (isAboutToExpire)
                            Padding(
                              padding: EdgeInsets.only(top: 6.h),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                                decoration: BoxDecoration(
                                  color: Colors.orange.withValues(alpha: 0.12),
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: Colors.orange.withValues(alpha: 0.25)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      size: 12.sp,
                                      color: Colors.orange.shade700,
                                    ),
                                    Gap(4.w),
                                    Text(
                                      'الحجز قريب من الانتهاء',
                                      style: AppTextStyle.bodySmall(context).copyWith(
                                        color: Colors.orange.shade800,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Cancel Button
                    GestureDetector(
                      onTap: _isCancelling ? null : _onDeleteTapped,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: AppColor.redColor(context).withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColor.redColor(context).withValues(alpha: 0.08),
                          ),
                        ),
                        child: _isCancelling
                            ? SizedBox(
                                width: 16.sp,
                                height: 16.sp,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation(AppColor.redColor(context)),
                                ),
                              )
                            : Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.close_rounded,
                                    size: 16.sp,
                                    color: AppColor.redColor(context).withValues(alpha: 0.7),
                                  ),
                                  Gap(6.w),
                                  Text(
                                    AppLocaleKey.cancelReservation.tr(),
                                    style: AppTextStyle.bodySmall(context).copyWith(
                                      color: AppColor.redColor(context).withValues(alpha: 0.7),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: AppColor.whiteColor(context),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: AppColor.redColor(context).withValues(alpha: 0.06),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.delete_outline_rounded,
                color: AppColor.redColor(context),
                size: 28.sp,
              ),
            ),
            Gap(16.h),
            Text(
              AppLocaleKey.cancelReservationTitle.tr(),
              style: AppTextStyle.titleMedium(
                context,
              ).copyWith(fontWeight: FontWeight.w700, fontSize: 18.sp),
            ),
            Gap(8.h),
            Text(
              AppLocaleKey.cancelReservationBody.tr(),
              style: AppTextStyle.bodyMedium(context).copyWith(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(24.h),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      side: BorderSide(
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      AppLocaleKey.cancelReservationNo.tr(),
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                      ),
                    ),
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.redColor(context),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                      elevation: 0,
                    ),
                    child: Text(
                      AppLocaleKey.cancelReservationYes.tr(),
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.w700),
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
