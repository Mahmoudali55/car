import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentAddAppointmentScreen extends StatefulWidget {
  const AgentAddAppointmentScreen({super.key});

  @override
  State<AgentAddAppointmentScreen> createState() => _AgentAddAppointmentScreenState();
}

class _AgentAddAppointmentScreenState extends State<AgentAddAppointmentScreen> {
  @override
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: IconBtn(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.pop(context),
          ),
        ),
        title: Text(
          'جدولة موعد جديد',
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
                'حدد تفاصيل الموعد مع العميل لضمان تجربة فحص أو اجتماع احترافية.',
                style: TextStyle(
                  color: AppColor.greyColor(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(24.h),
                        
              /// Form Fields
               CustomFormField(
                radius: 12.r,
                title: 'ابحث عن عميل',
                hintText: 'أدخل اسم العميل المسجل',
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              Gap(20.h),
               Row(
                children: [
                  Expanded(
                    child: CustomFormField(
                      controller: dateController,
                      readOnly: true,
                      radius: 12.r,
                      title: 'تاريخ الموعد',
                      hintText: 'اختر التاريخ',
                      prefixIcon: const Icon(Icons.calendar_today_rounded),
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );

                        if (pickedDate != null) {
                          dateController.text =
                              '${pickedDate.year}/${pickedDate.month}/${pickedDate.day}';
                        }
                      },
                    ),
                  ),

                  Gap(12.w),

                  Expanded(
                    child: CustomFormField(
                      controller: timeController,
                      readOnly: true,
                      radius: 12.r,
                      title: 'الوقت',
                      hintText: 'اختر الوقت',
                      prefixIcon: const Icon(Icons.access_time_rounded),
                      onTap: () async {
                        final pickedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now(),
                        );

                        if (pickedTime != null) {
                          timeController.text = pickedTime.format(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
              Gap(20.h),
               CustomFormField(
                radius: 12.r,
                title: 'موقع الموعد',
                hintText: 'اسم الفرع أو موقع العميل',
                prefixIcon: const Icon(Icons.location_on_outlined),
              ),
              Gap(20.h),
               CustomFormField(
                radius: 12.r,
                title: 'الغرض من الاجتماع',
                hintText: 'مثال: تجربة قيادة كامري 2024',
                prefixIcon: const Icon(Icons.info_outline_rounded),
                maxLines: 3,
              ),
                Gap(20.h),
          
              /// Bottom Action Bar
              CustomButton(
                onPressed: () => Navigator.pop(context),
                  radius: 12.r,
                
                child: Text(
                  'تأكيد جدولة الموعد',
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
