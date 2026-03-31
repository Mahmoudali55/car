import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/presentation/widget/car_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationCarSummary extends StatelessWidget {
  final Map<String, dynamic> car;

  const ReservationCarSummary({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.1)),
      ),
      child: CarHeaderWidget(car: car),
    );
  }
}

class ReservationTimerBanner extends StatelessWidget {
  final String formattedTime;

  const ReservationTimerBanner({super.key, required this.formattedTime});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            formattedTime,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w900,
              color: AppColor.primaryColor(context),
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class ReservationDepositDisplay extends StatelessWidget {
  final double depositAmount;

  const ReservationDepositDisplay({super.key, required this.depositAmount});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat('#,##0', 'en_US');
    return Center(
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
    );
  }
}

class ReservationWarningNotice extends StatelessWidget {
  const ReservationWarningNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class ReservationBuyerForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController ibanController;

  const ReservationBuyerForm({
    super.key,
    required this.nameController,
    required this.idController,
    required this.ibanController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
          controller: nameController,
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
          controller: idController,
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
          controller: ibanController,
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
      ],
    );
  }
}

class ReservationExpiredView extends StatelessWidget {
  final VoidCallback onOkPressed;

  const ReservationExpiredView({super.key, required this.onOkPressed});

  @override
  Widget build(BuildContext context) {
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
                onPressed: onOkPressed,
                child: Text(AppLocaleKey.ok.tr(), style: AppTextStyle.buttonStyle(context)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
