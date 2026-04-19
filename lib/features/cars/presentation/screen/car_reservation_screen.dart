import 'dart:async';

import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/car_reservation_widgets.dart';
import 'package:car/features/cars/presentation/widget/reservation_buyer_form_widget.dart';
import 'package:car/features/cars/presentation/widget/reservation_deposit_display_widget.dart';
import 'package:car/features/cars/presentation/widget/reservation_expired_widget.dart';
import 'package:car/features/cars/presentation/widget/reservation_timer_banner_widget.dart';
import 'package:car/features/cars/presentation/widget/reservation_warning_notice_widget.dart';
import 'package:car/features/cart/presentation/view/cubit/cart_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarReservationScreen extends StatefulWidget {
  final Map<String, dynamic> car;
  final bool isFromLink;

  const CarReservationScreen({super.key, required this.car, this.isFromLink = false});

  @override
  State<CarReservationScreen> createState() => _CarReservationScreenState();
}

class _CarReservationScreenState extends State<CarReservationScreen> {
  final _formKey = GlobalKey<FormState>();
  late Timer _timer;
  late Duration _timeRemaining;
  bool _isExpired = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _ibanController = TextEditingController();

  final double depositAmount = 500.0; // Mock fixed deposit

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    // 30 mins if from link, else 24 hours
    _timeRemaining = widget.isFromLink ? const Duration(minutes: 30) : const Duration(hours: 24);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining.inSeconds > 0) {
        setState(() {
          _timeRemaining -= const Duration(seconds: 1);
        });
      } else {
        setState(() {
          _isExpired = true;
        });
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _nameController.dispose();
    _idController.dispose();
    _ibanController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return '${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds';
    }
    return '$twoDigitMinutes:$twoDigitSeconds';
  }

  void _submitReservation() {
    if (_formKey.currentState!.validate() && !_isExpired) {
      context.read<CartCubit>().addToCart(widget.car);

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Center(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 600),
              tween: Tween(begin: 0.0, end: 1.0),
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: AlertDialog(
                    backgroundColor: AppColor.scaffoldColor(context),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundColor: Colors.green.withValues(alpha: 0.1),
                          child: Icon(Icons.check_circle_rounded, color: Colors.green, size: 50.sp),
                        ),
                        Gap(24.h),
                        Text(
                          AppLocaleKey.reservationSuccess.tr(),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blackTextColor(context),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Gap(12.h),
                        Text(
                          AppLocaleKey.whatsappSent.tr(),
                          style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], height: 1.5),
                          textAlign: TextAlign.center,
                        ),
                        Gap(24.h),
                        CustomButton(
                          height: 48.h,
                          width: double.infinity,
                          radius: 12.r,
                          child: Text(
                            AppLocaleKey.ok.tr(),
                            style: AppTextStyle.buttonStyle(context),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // close dialog
                            Navigator.pop(context); // close screen
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        title: Text(
          AppLocaleKey.reserveCar.tr(),
          style: TextStyle(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isExpired
          ? ReservationExpiredView(onOkPressed: () => Navigator.pop(context))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReservationCarSummary(car: widget.car),
                    Gap(24.h),
                    ReservationTimerBanner(formattedTime: _formatDuration(_timeRemaining)),
                    Gap(24.h),
                    ReservationDepositDisplay(depositAmount: depositAmount),
                    Gap(32.h),
                    const ReservationWarningNotice(),
                    Gap(24.h),
                    ReservationBuyerForm(
                      nameController: _nameController,
                      idController: _idController,
                      ibanController: _ibanController,
                    ),
                    Gap(40.h),
                    CustomButton(
                      height: 56.h,
                      width: double.infinity,
                      radius: 12.r,
                      onPressed: _submitReservation,
                      child: Text(
                        AppLocaleKey.payDeposit.tr(),
                        style: AppTextStyle.buttonStyle(
                          context,
                        ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Gap(40.h),
                  ],
                ),
              ),
            ),
    );
  }
}
