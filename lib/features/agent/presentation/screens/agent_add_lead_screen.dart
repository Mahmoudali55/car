import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentAddLeadScreen extends StatelessWidget {
  const AgentAddLeadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        elevation: 0,
        leading: IconBtn(
          icon: Icons.arrow_back_ios_new_rounded,
          onTap: () => Navigator.pop(context),
        ),
        title: Text(
          'إضافة عميل جديد',
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'أدخل تفاصيل العميل المهتم لبدء عملية المبيعات ومتابعة اهتماماته.',
                style: TextStyle(
                  color: AppColor.greyColor(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(24.h),
                        
              /// Form Fields
              const CustomFormField(
                title: 'اسم العميل الكامل',
                hintText: 'أدخل اسم العميل الثلاثي',
                prefixIcon: Icon(Icons.person_outline_rounded),
              ),
              Gap(20.h),
              const CustomFormField(
                title: 'رقم الهاتف',
                hintText: '05xxxxxxxx',
                prefixIcon: Icon(Icons.phone_android_rounded),
                keyboardType: TextInputType.phone,
              ),
              Gap(20.h),
              const CustomFormField(
                title: 'البريد الإلكتروني',
                hintText: 'example@mail.com',
                prefixIcon: Icon(Icons.email_outlined),
                keyboardType: TextInputType.emailAddress,
              ),
              Gap(20.h),
              const CustomFormField(
                title: 'السيارة المهتم بها',
                hintText: 'مثال: تويوتا كامري 2024',
                prefixIcon: Icon(Icons.directions_car_outlined),
              ),
              Gap(20.h),
              const CustomFormField(
                title: 'الميزانية المتوقعة (ر.س)',
                hintText: 'أدخل القيمة التقديرية',
                prefixIcon: Icon(Icons.payments_outlined),
                keyboardType: TextInputType.number,
              ),
          
              /// Bottom Action Bar
              Gap(40.h),
              CustomButton(
                onPressed: () => Navigator.pop(context),
                
               radius: 12.r,
                child: Text(
                  'حفظ العميل والبدء',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
