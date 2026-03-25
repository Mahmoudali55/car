import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AllActivitiesScreen extends StatelessWidget {
  const AllActivitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
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
          'سجل النشاطات الكامل',
          style: AppTextStyle.titleMedium(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 20,
        physics: const BouncingScrollPhysics(),
        separatorBuilder: (context, index) => Gap(12.h),
        itemBuilder: (context, index) => FadeInUp(
          delay: Duration(milliseconds: index * 30),
          child: _buildActivityCard(context, index),
        ),
      ),
    );
  }

  Widget _buildActivityCard(BuildContext context, int index) {
    final activities = [
      {
        'title': 'تم إضافة مرسيدس G-Class',
        'desc': 'بواسطة أدمن: محمد علي',
        'time': 'منذ 10 دقائق',
        'icon': Icons.add_business_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'طلب فحص جديد رقم #1204',
        'desc': 'من المستخدم: خالد عمر',
        'time': 'منذ 25 دقيقة',
        'icon': Icons.car_repair_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': 'مستخدم جديد انضم للنظام',
        'desc': 'البريد: omar@example.com',
        'time': 'منذ ساعة',
        'icon': Icons.person_add_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'اكتمال عملية دفع ناجحة',
        'desc': 'المبلغ: 12,500 د.إ',
        'time': 'منذ 3 ساعات',
        'icon': Icons.check_circle_rounded,
        'color': const Color(0xFF2DD4BF),
      },
    ];

    final act = activities[index % activities.length];

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: (act['color'] as Color).withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(
              act['icon'] as IconData,
              color: act['color'] as Color,
              size: 22.sp,
            ),
          ),
          Gap(16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  act['title'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gap(2.h),
                Text(
                  act['desc'] as String,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.4),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Text(
            act['time'] as String,
            style: TextStyle(
              color: Colors.white.withOpacity(0.3),
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
