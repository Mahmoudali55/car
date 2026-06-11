import 'dart:async';

import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatefulWidget {
  final Map<String, dynamic> car;

  const CartItemWidget({super.key, required this.car});

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _calculateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _calculateTime();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateTime() {
    if (widget.car.containsKey('reservedAt')) {
      final reservedAt = DateTime.tryParse(widget.car['reservedAt'].toString());
      if (reservedAt != null) {
        final expiryTime = reservedAt.add(const Duration(hours: 24));
        final remaining = expiryTime.difference(DateTime.now());
        if (remaining.isNegative) {
          _remainingTime = Duration.zero;
        } else {
          _remainingTime = remaining;
        }
        if (mounted) setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
          if (widget.car.containsKey('reservedAt') && _remainingTime > Duration.zero) ...[
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
                      ' ${AppLocaleKey.reservationDuration.tr()}  ${_remainingTime.inHours.toString().padLeft(2, '0')}${AppLocaleKey.hours.tr()}:${(_remainingTime.inMinutes % 60).toString().padLeft(2, '0')} ${AppLocaleKey.minutes.tr()}:${(_remainingTime.inSeconds % 60).toString().padLeft(2, '0')} ${AppLocaleKey.seconds.tr()}',
                      style: AppTextStyle.bodySmall(
                        context,
                      ).copyWith(color: AppColor.iconColor(context), fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
          Row(
            children: [
              // Car Image
              Container(
                width: 90.w,
                height: 70.h,
                decoration: BoxDecoration(
                  color: AppColor.scaffoldColor(context),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                clipBehavior: Clip.antiAlias,
                child:
                    (widget.car['image'] != null &&
                        widget.car['image'].toString().trim().startsWith('http'))
                    ? CustomNetworkImage(
                        imageUrl: widget.car['image'] as String,
                        fit: BoxFit.contain,
                        width: double.infinity,
                      )
                    : Image.asset(
                        (widget.car['image'] != null &&
                                widget.car['image'].toString().trim().isNotEmpty)
                            ? widget.car['image'] as String
                            : AppImages.assetsImagesPlaceholder,
                        fit: BoxFit.contain,
                      ),
              ),
              Gap(14.w),

              // Car Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.car['brand'] as String? ?? '',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      widget.car['name'] as String? ?? '',
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
                      widget.car['price'] as String? ?? '',
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              // Remove Button
              GestureDetector(
                onTap: () {
                  context.read<CartCubit>().removeFromCart(widget.car);
                },
                child: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 22.sp),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
