import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdCardBackground extends StatelessWidget {
  final Color accentColor;
  const AdCardBackground({super.key, required this.accentColor});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(right: -30.w, top: -30.h, child: _circle(160.w, 0.06)),
        Positioned(right: 10.w, bottom: -40.h, child: _circle(100.w, 0.04)),
      ],
    );
  }

  Widget _circle(double size, double opacity) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor.withValues(alpha: opacity),
      ),
    );
  }
}
