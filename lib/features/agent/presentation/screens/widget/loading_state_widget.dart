import 'package:car/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({required this.context});
  final BuildContext context;

  @override
  Widget build(BuildContext ctx) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
      itemCount: 5,
      itemBuilder: (_, __) => _ShimmerCard(),
    );
  }
}

class _ShimmerCard extends StatefulWidget {
  @override
  State<_ShimmerCard> createState() => _ShimmerCardState();
}

class _ShimmerCardState extends State<_ShimmerCard> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _anim = Tween<double>(
      begin: 0.3,
      end: 0.7,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColor.cardColor(context),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColor.borderColor(context).withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_box(80.w, 24.h), _box(70.w, 24.h)],
            ),
            Gap(14.h),
            Divider(height: 1, color: AppColor.borderColor(context).withValues(alpha: 0.12)),
            Gap(14.h),
            Row(
              children: [
                _box(42.w, 42.h, circle: true),
                Gap(12.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [_box(50.w, 11.h), Gap(6.h), _box(140.w, 15.h)],
                ),
              ],
            ),
            Gap(12.h),
            Row(
              children: [
                Expanded(child: _box(double.infinity, 34.h)),
                Gap(8.w),
                Expanded(child: _box(double.infinity, 34.h)),
              ],
            ),
            Gap(8.h),
            _box(double.infinity, 34.h),
            Gap(12.h),
            _box(double.infinity, 48.h),
          ],
        ),
      ),
    );
  }

  Widget _box(double w, double h, {bool circle = false}) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        color: AppColor.borderColor(context).withValues(alpha: _anim.value),
        borderRadius: circle ? BorderRadius.circular(100) : BorderRadius.circular(8.r),
      ),
    );
  }
}
