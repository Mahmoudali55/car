import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/car_header_widget.dart';
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
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    if (duration.inHours > 0) {
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _submitReservation() {
    if (_formKey.currentState!.validate() && !_isExpired) {
      // Add car to the cart successfully
      context.read<CartCubit>().addToCart(widget.car);

      // Simulate success
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
      body: _isExpired ? _buildExpiredView() : _buildActiveReservationForm(),
    );
  }

  Widget _buildExpiredView() {
    return Center(
      child: FadeInUp(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.timer_off_rounded, size: 80.sp, color: Colors.red),
              Gap(24.h),
              Text(
                AppLocaleKey.reservationExpired.tr(),
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blackTextColor(context),
                ),
              ),
              Gap(12.h),
              Text(
                AppLocaleKey.reservationExpiredDesc.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600], height: 1.5),
              ),
              Gap(40.h),
              CustomButton(
                height: 50.h,
                width: 200.w,
                radius: 12.r,
                onPressed: () => Navigator.pop(context),
                child: Text(AppLocaleKey.ok.tr(), style: AppTextStyle.buttonStyle(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActiveReservationForm() {
    final formatter = NumberFormat('#,##0', 'en_US');

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.all(24.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Car Summary
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColor.secondAppColor(context),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
              ),
              child: CarHeaderWidget(car: widget.car),
            ),
            Gap(24.h),

            // Timer Banner
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.timer_outlined, color: AppColor.primaryColor(context)),
                      Gap(8.w),
                      Text(
                        AppLocaleKey.timeRemaining.tr(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.blackTextColor(context),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    _formatDuration(_timeRemaining),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColor.primaryColor(context),
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),

            // Deposit Amount
            Center(
              child: Column(
                children: [
                  Text(
                    AppLocaleKey.depositAmount.tr(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
                  ),
                  Gap(8.h),
                  Text(
                    '${formatter.format(depositAmount)} ${AppLocaleKey.sar.tr()}',
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),

            // Warning Notice
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.amber.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.amber, size: 20.sp),
                  Gap(8.w),
                  Expanded(
                    child: Text(
                      AppLocaleKey.nameMustMatch.tr(),
                      style: TextStyle(color: Colors.amber[800], fontSize: 12.sp, height: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            Gap(24.h),

            // Buyer Name
            Text(
              AppLocaleKey.buyerName.tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.blackTextColor(context),
              ),
            ),
            Gap(8.h),
            CustomFormField(
              controller: _nameController,
              hintText: AppLocaleKey.buyerNameHint.tr(),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocaleKey.validateEmpty.tr();
                }
                return null;
              },
            ),
            Gap(16.h),

            // Buyer ID
            Text(
              AppLocaleKey.buyerId.tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.blackTextColor(context),
              ),
            ),
            Gap(8.h),
            CustomFormField(
              controller: _idController,
              hintText: '10XXXXXX',
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocaleKey.validateEmpty.tr();
                }
                return null;
              },
            ),
            Gap(16.h),

            // Buyer IBAN
            Text(
              AppLocaleKey.buyerIban.tr(),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColor.blackTextColor(context),
              ),
            ),
            Gap(8.h),
            CustomFormField(
              controller: _ibanController,
              hintText: 'SAXXXXXXXXXXXXXXXXXXXXXX',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocaleKey.validateEmpty.tr();
                }
                if (!value.startsWith('SA') && value.length < 10) {
                  return AppLocaleKey.validateEmpty.tr(); // Generically invalid for demo
                }
                return null;
              },
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
    );
  }
}
