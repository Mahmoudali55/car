import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_otp_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class OtpBottomSheet extends StatefulWidget {
  final String phoneNumber;
  final VoidCallback onVerified;

  const OtpBottomSheet({
    super.key,
    required this.phoneNumber,
    required this.onVerified,
  });

  @override
  State<OtpBottomSheet> createState() => _OtpBottomSheetState();
}

class _OtpBottomSheetState extends State<OtpBottomSheet> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColor.borderColor(context),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          Gap(32.h),
          Text(
            "التحقق من رقم الجوال",
            style: AppTextStyle.titleMedium(context).copyWith(
              fontWeight: FontWeight.w900,
              fontSize: 20.sp,
            ),
          ),
          Gap(12.h),
          Text(
            "أدخل رمز التحقق المرسل إلى الرقم ${widget.phoneNumber}",
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmall(context).copyWith(
              color: AppColor.blackTextColor(context).withOpacity(0.5),
              fontSize: 14.sp,
            ),
          ),
          Gap(32.h),
          CustomOtpField(
            length: 4,
            controller: _otpController,
            onCompleted: (pin) {
              // Auto-confirm logic can go here
            },
          ),
          Gap(32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "لم يصلك الرمز؟",
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.blackTextColor(context).withOpacity(0.5),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  "إعادة إرسال",
                  style: TextStyle(
                    color: AppColor.primaryColor(context),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Gap(32.h),
          CustomButton(
            height: 56.h,
            width: double.infinity,
            radius: 12.r,
            onPressed: widget.onVerified,
            child: Text(
              "تأكيد",
              style: AppTextStyle.buttonStyle(context),
            ),
          ),
        ],
      ),
    );
  }
}
