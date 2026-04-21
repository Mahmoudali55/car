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

  const PaymentMethodSelectionCard({
    super.key,
    required this.title,
    this.badgeText,
    required this.description,
    this.logo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected ? AppColor.primaryColor(context) : AppColor.borderColor(context),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColor.primaryColor(context).withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
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
                      if (logo != null) ...[
                        logo!,
                        Gap(12.w),
                      ],
                      Expanded(
                        child: Text(
                          title,
                          style: AppTextStyle.titleMedium(context).copyWith(
                            fontWeight: FontWeight.w900,
                            fontSize: 14.sp,
                            color: AppColor.blackTextColor(context),
                          ),
                        ),
                      ),
                      if (badgeText != null) ...[
                        Gap(12.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            badgeText!,
                            style: TextStyle(
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
                      color: AppColor.blackTextColor(context).withOpacity(0.5),
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
                  color: isSelected ? AppColor.primaryColor(context) : AppColor.borderColor(context),
                  width: 2,
                ),
              ),
              child: isSelected
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
