import 'package:car/features/admin/presentation/screen/widgets/stat_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FleetStatsRow extends StatelessWidget {
  final List<Map<String, dynamic>> cars;

  const FleetStatsRow({super.key, required this.cars});

  int _count(String status) => cars.where((c) => c['status'] == status).length;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
      child: Row(
        children: [
          StatCard(
            count: _count('published'),
            label: 'منشور',
            dotColor: const Color(0xFF3B6D11),
            context: context,
          ),
          Gap(10.w),
          StatCard(
            count: _count('pending'),
            label: 'معلق',
            dotColor: const Color(0xFF854F0B),
            context: context,
          ),
          Gap(10.w),
          StatCard(
            count: _count('deleted'),
            label: 'محذوف',
            dotColor: const Color(0xFFA32D2D),
            context: context,
          ),
        ],
      ),
    );
  }
}
