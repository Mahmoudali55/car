import 'dart:async';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class FinancingOtpBottomSheet extends StatefulWidget {
  const FinancingOtpBottomSheet({super.key});

  @override
  State<FinancingOtpBottomSheet> createState() => _FinancingOtpBottomSheetState();
}

class _FinancingOtpBottomSheetState extends State<FinancingOtpBottomSheet> {
  final _pinController = TextEditingController();
  final _focusNode = FocusNode();
  
  bool _isError = false;
  int _secondsRemaining = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    setState(() => _secondsRemaining = 60);
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pinController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _formattedTime {
    final m = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final s = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  void _verify() {
    if (_pinController.text.length == 4) {
      Navigator.pop(context, true);
    } else {
      setState(() => _isError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        color: AppColor.blackTextColor(context),
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.borderColor(context)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: AppColor.primaryColor(context), width: 1.5),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        border: Border.all(color: Colors.red.shade400, width: 1.5),
      ),
    );

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24.w,
        right: 24.w,
        top: 24.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Gap(24.h),
          Text(
            'رمز التحقق (OTP)',
            style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.w900),
          ),
          Gap(8.h),
          Text(
            'أدخل رمز التحقق المرسل إلى رقم جوالك',
            style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
            textAlign: TextAlign.center,
          ),
          Gap(32.h),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Pinput(
              length: 4,
              controller: _pinController,
              focusNode: _focusNode,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              errorPinTheme: errorPinTheme,
              forceErrorState: _isError,
              onChanged: (v) {
                if (_isError) setState(() => _isError = false);
              },
              onCompleted: (v) => _verify(),
            ),
          ),
          Gap(24.h),
          // Timer and resend row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _secondsRemaining > 0 ? _formattedTime : '',
                style: AppTextStyle.bodyMedium(context).copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColor.primaryColor(context),
                ),
              ),
              if (_secondsRemaining > 0) Gap(8.w),
              GestureDetector(
                onTap: _secondsRemaining == 0 ? _startTimer : null,
                child: Text(
                  _secondsRemaining > 0 ? 'إعادة إرسال الرمز بعد' : 'إعادة إرسال الرمز',
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    color: _secondsRemaining == 0 
                      ? AppColor.primaryColor(context)
                      : AppColor.greyColor(context),
                    fontWeight: _secondsRemaining == 0 ? FontWeight.bold : FontWeight.normal,
                    decoration: _secondsRemaining == 0 ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),
          Gap(32.h),
          CustomButton(
            onPressed: _verify,
            radius: 12.r,
            child: Text(
              'تحقق ومتابعة',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          Gap(32.h),
        ],
      ),
    );
  }
}
