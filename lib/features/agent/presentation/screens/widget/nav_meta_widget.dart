import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class NavMeta {
  final IconData icon;
  final String label;
  const NavMeta({required this.icon, required this.label});
}

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final List<NavMeta> items;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, 
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.appBarColor(context),
        border: Border(
          top: BorderSide(color: AppColor.borderColor(context), width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.blueColor(context).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = currentIndex == i;
              final color = selected ? AppColor.blueColor(context) : AppColor.hintColor(context);

              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutQuint,
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColor.blueColor(context).withOpacity(0.08)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[i].icon,
                        size: 24.sp,
                        color: color,
                      ),
                      Gap(4.h),
                      Text(
                        items[i].label,
                        style: TextStyle(
                          fontSize: 11.sp,
                          letterSpacing: -0.2,
                          fontWeight: selected ? FontWeight.w900 : FontWeight.w600,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
