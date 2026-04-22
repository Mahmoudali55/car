import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommRow extends StatelessWidget {
  final String label;
  final String value;
  final Color color;
  const CommRow({super.key, required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: Colors.grey, fontSize: 13.sp, fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(color: color, fontWeight: FontWeight.w900, fontSize: 15.sp)),
      ],
    );
  }
}