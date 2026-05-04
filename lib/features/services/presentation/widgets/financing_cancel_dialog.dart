import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CancelDialog extends StatelessWidget {
  final BuildContext context;

  const CancelDialog({required this.context});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildWarningIcon(context),
            Gap(20.h),
            _buildTitle(context),
            Gap(12.h),
            _buildDescription(context),
            Gap(24.h),
            _buildContinueButton(context),
            Gap(10.h),
            _buildCancelButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningIcon(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        color: AppColor.orangeColor(context).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Icon(Icons.warning_amber_rounded, color: AppColor.orangeColor(context), size: 32.sp),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AppLocaleKey.agentCancelOrder.tr(),
      textAlign: TextAlign.center,
      style: AppTextStyle.titleSmall(
        context,
      ).copyWith(fontWeight: FontWeight.w900, fontSize: 16.sp),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Text(
      AppLocaleKey.agentCancelOrderDesc.tr(),
      textAlign: TextAlign.center,
      style: AppTextStyle.bodySmall(
        context,
      ).copyWith(color: AppColor.greyColor(context), height: 1.5),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return CustomButton(
      radius: 12.r,
      onPressed: () => Navigator.pop(context, false),
      child: Text(
        AppLocaleKey.agentContinueOrder.tr(),
        style: AppTextStyle.bodyLarge(context).copyWith(color: AppColor.whiteColor(context)),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return CustomButton(
      onPressed: () => Navigator.pop(context, true),
      borderColor: AppColor.primaryColor(context),
      radius: 12.r,
      color: AppColor.whiteColor(context),
      child: Text(
        AppLocaleKey.agentCancelOrder.tr(),
        style: AppTextStyle.bodyMedium(
          context,
        ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.w700),
      ),
    );
  }
}
