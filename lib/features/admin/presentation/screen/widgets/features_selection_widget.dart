import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeaturesSelectionWidget extends StatefulWidget {
  const FeaturesSelectionWidget({super.key, required this.features, required this.selectedOptions});
  final List<String> features;
  final List<String> selectedOptions;

  @override
  State<FeaturesSelectionWidget> createState() => _FeaturesSelectionWidgetState();
}

class _FeaturesSelectionWidgetState extends State<FeaturesSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10.w,
      runSpacing: 10.h,
      children: widget.features.map((feature) {
        final isSelected = widget.selectedOptions.contains(feature);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                widget.selectedOptions.remove(feature);
              } else {
                widget.selectedOptions.add(feature);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColor.primaryColor(context)
                  : AppColor.blackTextColor(context).withOpacity(0.03),
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(
                color: isSelected
                    ? Colors.transparent
                    : AppColor.blackTextColor(context).withOpacity(0.05),
              ),
            ),
            child: Text(
              feature,
              style: TextStyle(
                color: isSelected
                    ? Colors.white
                    : AppColor.blackTextColor(context).withOpacity(0.5),
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
