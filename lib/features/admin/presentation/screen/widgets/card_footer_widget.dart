import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/car_inventory_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardFooter extends StatelessWidget {
  final Map<String, String> car;
  final BuildContext context;
  final VoidCallback? onEdit;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onDelete;
  const CardFooter({
    required this.car,
    required this.context,
    this.onEdit,
    this.onWhatsApp,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          ' ${car['price'] ?? ''} ${AppLocaleKey.sar.tr()}',
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w600, color: AppColor.blackTextColor(context)),
        ),
        const Spacer(),
        ActionBtn(icon: Icons.edit_rounded, onTap: onEdit),
        Gap(6.w),
        ActionBtn(icon: Icons.phone, onTap: onWhatsApp),
        Gap(6.w),
        ActionBtn(icon: Icons.delete_outline_rounded, onTap: onDelete, isDanger: true),
      ],
    );
  }
}
