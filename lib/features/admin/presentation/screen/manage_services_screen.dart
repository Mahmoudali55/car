import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ManageServicesScreen extends StatelessWidget {
  const ManageServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.manageServices.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(20.w),
        itemCount: 8,
        separatorBuilder: (context, index) => Gap(16.h),
        itemBuilder: (context, index) => _buildServiceItem(context, index),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, int index) {
    final services = [
      'التبديل (Trade-In)',
      'الاستيراد حسب الطلب',
      'التمويل',
      'العناية الكاملة بالسيارة',
      'الشحن والتوصيل',
      'الاختيارات المخصصة',
      'تقييم السيارة',
      'بيع سيارتك',
    ];
    // These should ideally be in ar.json if they are static content

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.03)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.build_circle_outlined,
                  color: AppColor.primaryColor(context),
                  size: 24.sp,
                ),
              ),
              Gap(16.w),
              Text(
                services[index],
                style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 13.sp, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Switch(value: true, onChanged: (v) {}, activeThumbColor: AppColor.primaryColor(context)),
        ],
      ),
    );
  }
}
