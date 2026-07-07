import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdsDotIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color activeColor;
  final ValueChanged<int> onDotTapped;
  const AdsDotIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
    required this.activeColor,
    required this.onDotTapped,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final isSelected = i == currentIndex;
        return GestureDetector(
          onTap: () => onDotTapped(i),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            margin: EdgeInsets.symmetric(horizontal: 3.w),
            width: isSelected ? 22.w : 6.w,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.r),
              color: isSelected ? activeColor : Colors.grey.withValues(alpha: 0.3),
            ),
          ),
        );
      }),
    );
  }
}
