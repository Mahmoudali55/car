import 'package:car/features/admin/presentation/screen/widgets/car_inventory_card.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CardFooter extends StatelessWidget {
  final GetBrandCarsDataModel car;
  final BuildContext context;
  final VoidCallback? onEdit;
  final VoidCallback? onWhatsApp;
  final VoidCallback? onDelete;
  final VoidCallback? onPrint;
  const CardFooter({
    super.key,
    required this.car,
    required this.context,
    this.onEdit,
    this.onWhatsApp,
    this.onDelete,
    this.onPrint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        ActionBtn(icon: Icons.print_rounded, onTap: onPrint),
        Gap(6.w),
        ActionBtn(icon: Icons.edit_rounded, onTap: onEdit),
        Gap(6.w),
        ActionBtn(icon: Icons.phone, onTap: onWhatsApp),
        Gap(6.w),
        ActionBtn(icon: Icons.delete_outline_rounded, onTap: onDelete, isDanger: true),
      ],
    );
  }
}
