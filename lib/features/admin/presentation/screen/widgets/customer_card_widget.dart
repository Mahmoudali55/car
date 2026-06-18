import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/data/model/customer_model.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_info_row_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/user_details_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomerCardWidget extends StatelessWidget {
  const CustomerCardWidget({
    super.key,
    required this.customer,
    required this.roleColor,
    required this.roleLabel,
  });
  final CustomerModel customer;
  final Color roleColor;
  final String roleLabel;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => UserDetailsBottomSheet(
            name: customer.customerName ?? customer.customerNameEng ?? '#${customer.customerNo}',
            id: customer.customerNo.toString(),
            roleLabel: roleLabel,
            roleColor: roleColor,
            phone: customer.tel1,
            area: customer.areaName,
            address: customer.address,
            balance: customer.balanceLocal,
            notes: customer.notes,
          ),
        );
      },
      borderRadius: BorderRadius.circular(28.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColor.whiteColor(context),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: roleColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Icon(
                    roleLabel == AppLocaleKey.admins.tr()
                        ? Icons.storefront_rounded
                        : Icons.person_outline_rounded,
                    color: roleColor,
                    size: 24.sp,
                  ),
                ),
                Gap(16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        customer.customerName ??
                            customer.customerNameEng ??
                            '#${customer.customerNo}',
                        style: AppTextStyle.bodyLarge(context).copyWith(
                          color: AppColor.blackTextColor(context),
                          fontWeight: FontWeight.w900,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(4.h),
                      Text(
                        '${AppLocaleKey.code.tr()}: ${customer.customerNo}',
                        style: AppTextStyle.bodySmall(context).copyWith(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.4),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(20.h),
            CustomInfoRowWidget(
              icon: Icons.phone_android_rounded,
              text: customer.tel1 ?? AppLocaleKey.noData.tr(),
            ),
            Gap(10.h),
            CustomInfoRowWidget(
              icon: Icons.location_on_rounded,
              text: customer.areaName ?? AppLocaleKey.noData.tr(),
            ),
            if (customer.balanceLocal != null) ...[
              Gap(10.h),
              CustomInfoRowWidget(
                icon: Icons.account_balance_wallet_rounded,
                text: '${customer.balanceLocal!.toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}',
                iconColor: Colors.green,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
