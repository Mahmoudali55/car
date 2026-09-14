import 'package:car/core/custom_widgets/custom_sar_text.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PaymentMethodSelectionCard extends StatelessWidget {
  final String title;
  final String? badgeText;
  final String description;
  final Widget? logo;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isEnabled;
  final String? disabledBadgeText;

  const PaymentMethodSelectionCard({
    super.key,
    required this.title,
    this.badgeText,
    required this.description,
    this.logo,
    required this.isSelected,
    required this.onTap,
    this.isEnabled = true,
    this.disabledBadgeText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: isEnabled
              ? AppColor.cardColor(context)
              : AppColor.cardColor(context).withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected && isEnabled
                ? AppColor.primaryColor(context)
                : AppColor.borderColor(context),
            width: isSelected && isEnabled ? 1.5 : 1,
          ),
          boxShadow: isSelected && isEnabled
              ? [
                  BoxShadow(
                    color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (logo != null) ...[logo!, Gap(12.w)],
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyle.bodyMedium(context).copyWith(
                            fontWeight: FontWeight.w900,
                            color: AppColor.blackTextColor(context),
                          ),
                        ),
                      ),
                      if (!isEnabled && disabledBadgeText != null) ...[
                        Gap(8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            disabledBadgeText!,
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: Colors.grey[700],
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ] else if (badgeText != null) ...[
                        Gap(12.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: ValueWithCurrencyIcon(
                            text: badgeText!,
                            textStyle: AppTextStyle.bodySmall(context).copyWith(
                              color: const Color(0xFF2E7D32),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Gap(12.h),
                  Text(
                    description,
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                      height: 1.6,
                      fontSize: 11.sp,
                    ),
                  ),
                ],
              ),
            ),
            Gap(16.w),
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: !isEnabled
                      ? AppColor.borderColor(context).withValues(alpha: 0.5)
                      : (isSelected
                            ? AppColor.primaryColor(context)
                            : AppColor.borderColor(context)),
                  width: 2,
                ),
              ),
              child: isSelected && isEnabled
                  ? Center(
                      child: Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColor.primaryColor(context),
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
