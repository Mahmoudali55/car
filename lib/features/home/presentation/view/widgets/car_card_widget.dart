import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/home/presentation/view/widgets/card_content_section_widget.dart';
import 'package:car/features/home/presentation/view/widgets/card_image_section_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarCard extends StatelessWidget {
  const CarCard({required this.car, required this.isSelected, required this.onTap});

  final Map<String, dynamic> car;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutQuint,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: isSelected ? 10.h : 20.h),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(
            color: isSelected
                ? AppColor.primaryColor(context).withValues(alpha: (0.3))
                : AppColor.blackTextColor(context).withValues(alpha: (0.05)),
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColor.primaryColor(context).withValues(alpha: (0.15))
                  : AppColor.blackColor(context).withValues(alpha: (0.1)),
              blurRadius: isSelected ? 20 : 10,
              offset: isSelected ? const Offset(0, 10) : const Offset(0, 5),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: CardImageSection(car: car, isSelected: isSelected),
            ),
            Expanded(
              flex: 15,
              child: CardContentSection(car: car, onTap: onTap),
            ),
          ],
        ),
      ),
    );
  }
}
