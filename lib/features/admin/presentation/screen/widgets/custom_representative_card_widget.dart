import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/data/model/representative_model.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_info_row_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/user_details_bottom_sheet.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomRepresentativeCardWidget extends StatelessWidget {
  const CustomRepresentativeCardWidget({super.key, required this.roleColor, required this.rep});

  final Color roleColor;
  final RepresentativeModel rep;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => UserDetailsBottomSheet(
            name: rep.represName ?? rep.represNameEng ?? '#${rep.represNo}',
            id: rep.represNo.toString(),
            roleLabel: AppLocaleKey.employees.tr(),
            roleColor: roleColor,
            phone: rep.tel1,
            area: rep.areaName,
            address: rep.address,
            balance: rep.balanceLocal,
            notes: rep.notes,
          ),
        );
      },
      borderRadius: BorderRadius.circular(28.r),
      child: Card(
        color: AppColor.secondAppColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                    child: Icon(Icons.badge_outlined, color: roleColor, size: 24.sp),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rep.represName ?? rep.represNameEng ?? '#${rep.represNo}',
                          style: AppTextStyle.bodyLarge(context).copyWith(
                            color: AppColor.blackTextColor(context),
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(4.h),
                        Text(
                          '${AppLocaleKey.code.tr()}:${rep.represNo}',
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
                text: rep.tel1 ?? AppLocaleKey.noData.tr(),
              ),
              Gap(10.h),
              CustomInfoRowWidget(
                icon: Icons.location_on_rounded,
                text: rep.areaName ?? AppLocaleKey.noData.tr(),
              ),
              if (rep.balanceLocal != null) ...[
                Gap(10.h),
                CustomInfoRowWidget(
                  icon: Icons.account_balance_wallet_rounded,
                  text: '${rep.balanceLocal!.toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}',
                  iconColor: Colors.green,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
