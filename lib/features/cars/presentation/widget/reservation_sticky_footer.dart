import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/screen/car_reservation_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationStickyFooter extends StatelessWidget {
  final ReservationScreenStep currentStep;
  final String? selectedMethod;
  final bool isFinancingFlow;
  final double depositAmount;
  final VoidCallback onContinue;

  const ReservationStickyFooter({
    super.key,
    required this.currentStep,
    required this.selectedMethod,
    required this.isFinancingFlow,
    required this.depositAmount,
    required this.onContinue,
  });

  @override
  Widget build(BuildContext context) {
    if (currentStep == ReservationScreenStep.payment) return const SizedBox.shrink();

    final isMethodSelection = currentStep == ReservationScreenStep.methodSelection;
    final canContinue = selectedMethod != null;

    String buttonLabel = AppLocaleKey.agentContinue.tr();
    Color buttonColor = canContinue
        ? AppColor.primaryColor(context)
        : (Colors.grey[300] ?? Colors.grey);

    if (!isMethodSelection) {
      if (isFinancingFlow) {
        buttonLabel = selectedMethod == 'tamara'
            ? AppLocaleKey.agentContinueWithTamara.tr()
            : AppLocaleKey.agentContinueWithBank.tr();
        buttonColor = const Color(0xFF3F51B5);
      } else {
        buttonLabel = AppLocaleKey.agentCompletePayment.tr();
        buttonColor = const Color(0xff00c853);
      }
    }

    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 30.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: CustomButton(
        height: 56.h,
        width: double.infinity,
        radius: 12.r,
        color: canContinue ? buttonColor : (Colors.grey[300] ?? Colors.grey),
        onPressed: canContinue ? onContinue : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!isMethodSelection && !isFinancingFlow) ...[
              ValueWithCurrencyIcon(
                text: '${depositAmount.toInt()} ${AppLocaleKey.sar.tr()}',
                textStyle: AppTextStyle.buttonStyle(context).copyWith(fontWeight: FontWeight.bold),
              ),
              Gap(16.w),
            ],
            if (isFinancingFlow && !isMethodSelection) ...[
              Icon(Icons.arrow_back_rounded, color: AppColor.whiteColor(context), size: 18.sp),
              Gap(12.w),
            ],
            Text(
              buttonLabel,
              style: AppTextStyle.buttonStyle(context).copyWith(
                color: canContinue ? AppColor.whiteColor(context) : Colors.grey[600],
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
