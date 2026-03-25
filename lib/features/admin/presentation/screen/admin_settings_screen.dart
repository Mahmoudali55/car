import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AdminSettingsScreen extends StatelessWidget {
  const AdminSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              )
            : null,
        title: Text(
          'إعدادات الإدارة',
          style: AppTextStyle.titleMedium(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Glow
          Positioned(
            bottom: -50.h,
            right: -50.w,
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.02),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.02),
                    blurRadius: 100,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.all(24.w),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(context, 'إعدادات النظام', [
                  _buildSettingItem(
                    Icons.security_rounded,
                    'الأمان والخصوصية',
                    'إدارة كلمات المرور والصلاحيات',
                  ),
                  _buildSettingItem(
                    Icons.language_rounded,
                    'لغة التطبيق',
                    'العربية - الإنجليزية',
                  ),
                  _buildSettingItem(
                    Icons.notifications_active_rounded,
                    'إشعارات النظام',
                    'تخصيص تنبيهات الأدمن',
                  ),
                ]),
                Gap(32.h),
                _buildSection(context, 'إدارة المحتوى', [
                  _buildSettingItem(
                    Icons.category_rounded,
                    'إدارة الفئات',
                    'تعديل أنواع السيارات والعلامات',
                  ),
                  _buildSettingItem(
                    Icons.discount_rounded,
                    'كوبونات الخصم',
                    'إدارة العروض والخصومات',
                  ),
                  _buildSettingItem(
                    Icons.policy_rounded,
                    'الشروط والأحكام',
                    'تحديث سياسات الاستخدام',
                  ),
                ]),
                Gap(32.h),
                _buildSection(context, 'الدعم الفني', [
                  _buildSettingItem(
                    Icons.help_outline_rounded,
                    'مركز المساعدة',
                    'دليل استخدام لوحة التحكم',
                  ),
                  _buildSettingItem(
                    Icons.contact_support_outlined,
                    'تواصل مع المبرمج',
                    'رفع تذكرة دعم فني',
                  ),
                ]),
                Gap(40.h),
                _buildLogoutButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(0.5),
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(16.h),
        ...items,
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title, String subtitle) {
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: ListTile(
          leading: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20.sp),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.white.withOpacity(0.4),
              fontSize: 11.sp,
            ),
          ),
          trailing: Icon(
            Icons.chevron_left_rounded,
            color: Colors.white.withOpacity(0.2),
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.redAccent.withOpacity(0.1)),
        ),
        child: ListTile(
          onTap: () {},
          leading: const Icon(Icons.logout_rounded, color: Colors.redAccent),
          title: const Text(
            'تسجيل الخروج',
            style: TextStyle(
              color: Colors.redAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(
            Icons.chevron_left_rounded,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
