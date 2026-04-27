import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/common/presentation/screen/widgets/bulid_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentResultScreen extends StatelessWidget {
  final bool isSuccess;
  final String providerName;

  const PaymentResultScreen({super.key, required this.isSuccess, required this.providerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              BulidIconWidget(isSuccess: isSuccess),
              Gap(32.h),
              Text(
                isSuccess ? 'Payment Successful!' : 'Payment Failed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColor.blackTextColor(context),
                ),
              ),
              Gap(12.h),
              Text(
                isSuccess
                    ? 'Your transaction with $providerName has been completed successfully.'
                    : 'Something went wrong with your $providerName transaction. Please try again or contact support.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: AppColor.greyColor(context), height: 1.5),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: CustomButton(
                  radius: 12.r,
                  onPressed: () {
                    // Navigate back to Home or previous screen
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    isSuccess ? 'Continue Browsing' : 'Back to Home',
                    style: TextStyle(
                      color: AppColor.whiteColor(context),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
                  ),
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
