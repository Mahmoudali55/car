import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class InspectionReportsScreen extends StatelessWidget {
  const InspectionReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'تقارير الفحص',
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 6,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) => _buildReportItem(context, index),
      ),
    );
  }

  Widget _buildReportItem(BuildContext context, int index) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.03)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'تقرير رقم #${1000 + index}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '2024/03/25',
                style: TextStyle(color: Colors.white38, fontSize: 11.sp),
              ),
            ],
          ),
          Gap(12.h),
          Text(
            'الحالة: فحص شامل مكتمل',
            style: TextStyle(color: Colors.white70, fontSize: 12.sp),
          ),
          Gap(12.h),
          Row(
            children: [
              const Icon(
                Icons.check_circle_rounded,
                color: Colors.green,
                size: 16,
              ),
              Gap(8.w),
              Text(
                'النتيجة: 95/100 (ممتاز)',
                style: TextStyle(color: Colors.green, fontSize: 12.sp),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: const Text('عرض التقرير الكامل'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
