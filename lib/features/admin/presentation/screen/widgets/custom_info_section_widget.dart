import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_detail_row_widget.dart';
import 'package:car/features/admin/presentation/screen/widgets/custom_divider_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInfoSectionWidget extends StatelessWidget {
  const CustomInfoSectionWidget({
    super.key,
    required this.id,
    required this.phone,
    required this.area,
    required this.address,
    required this.balance,
    required this.notes,
  });

  final String id;
  final String? phone;
  final String? area;
  final String? address;
  final double? balance;
  final String? notes;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: AppColor.whiteColor(context),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomDetailRowWidget(
            icon: Icons.fingerprint_rounded,
            label: AppLocaleKey.code.tr(),
            value: id,
          ),
          if (phone != null && phone!.isNotEmpty) ...[
            CustomDividerWidget(),
            CustomDetailRowWidget(
              icon: Icons.phone_android_rounded,
              label: AppLocaleKey.phone.tr(),
              value: phone!,
            ),
          ],
          if (area != null && area!.isNotEmpty) ...[
            CustomDividerWidget(),
            CustomDetailRowWidget(
              icon: Icons.location_on_rounded,
              label: AppLocaleKey.area.tr(),
              value: area!,
            ),
          ],
          if (address != null && address!.isNotEmpty) ...[
            CustomDividerWidget(),
            CustomDetailRowWidget(
              icon: Icons.map_rounded,
              label: AppLocaleKey.address.tr(),
              value: address!,
            ),
          ],
          if (balance != null) ...[
            CustomDividerWidget(),
            CustomDetailRowWidget(
              icon: Icons.account_balance_wallet_rounded,
              label: AppLocaleKey.balance.tr(),
              value: '${balance!.toStringAsFixed(2)} ${AppLocaleKey.sar.tr()}',
              valueColor: Colors.green,
            ),
          ],
          if (notes != null && notes!.isNotEmpty) ...[
            CustomDividerWidget(),
            CustomDetailRowWidget(
              icon: Icons.notes_rounded,
              label: AppLocaleKey.notes.tr(),
              value: notes!,
            ),
          ],
        ],
      ),
    );
  }
}
