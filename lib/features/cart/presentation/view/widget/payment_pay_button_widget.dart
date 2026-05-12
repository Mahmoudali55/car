import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentPayButtonWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;
  final String title;
  final IconData? icon;

  const PaymentPayButtonWidget({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.title,
    this.icon = Icons.lock_rounded,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.primaryColor(context),
          disabledBackgroundColor: AppColor.primaryColor(context).withOpacity(0.5),
          padding: EdgeInsets.symmetric(vertical: 18.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.r)),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 22.h,
                width: 22.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation(AppColor.blackTextColor(context)),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: AppColor.whiteColor(context), size: 20.sp),
                    Gap(10.w),
                  ],
                  Text(
                    title,
                    style: AppTextStyle.titleMedium(
                      context,
                    ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
                  ),
                ],
              ),
      ),
    );
  }
}
