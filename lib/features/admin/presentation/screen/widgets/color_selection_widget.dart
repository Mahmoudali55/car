import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ColorSelectionWidget extends StatefulWidget {
  const ColorSelectionWidget({
    super.key,
    required this.availableColors,
    required this.selectedColors,
  });
  final List<Color> availableColors;
  final List<Color> selectedColors;

  @override
  State<ColorSelectionWidget> createState() => _ColorSelectionWidgetState();
}

class _ColorSelectionWidgetState extends State<ColorSelectionWidget> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: widget.availableColors.map((color) {
        final isSelected = widget.selectedColors.contains(color);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                widget.selectedColors.remove(color);
              } else {
                widget.selectedColors.add(color);
              }
            });
          },
          child: Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColor.primaryColor(context) : Colors.transparent,
                width: 3,
              ),
              boxShadow: isSelected
                  ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 10)]
                  : null,
            ),
            child: isSelected ? const Icon(Icons.check, color: Colors.white, size: 20) : null,
          ),
        );
      }).toList(),
    );
  }
}
