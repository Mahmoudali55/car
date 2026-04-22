import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentAddNoteScreen extends StatelessWidget {
  const AgentAddNoteScreen({super.key});

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
          'إضافة ملاحظة مهنية',
          style: TextStyle(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 18.sp,
          ),
        ),
        centerTitle: true,
      ),
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                'سجل ملاحظاتك حول اهتمامات العميل أو تفاصيل المتابعة لضمان استمرارية العمل.',
                style: TextStyle(
                  color: AppColor.greyColor(context),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Gap(24.h),
                  
              /// Form Fields
               CustomFormField(
                radius:12.r,
                title: 'العميل المستهدف',
                hintText: 'ابحث عن اسم العميل المعني',
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              Gap(20.h),
               CustomFormField(
                radius:12.r,
                title: 'نص الملاحظة',
                hintText: 'اكتب هنا ما تم مناقشته أو ملاحظته...',
                prefixIcon: const Icon(Icons.edit_note_rounded),
                maxLines: 6,
              ),
              Gap(24.h),
                  
              /// Category Selection Mock
              Text(
                'تصنيف الملاحظة',
                style: TextStyle(
                  color: AppColor.blackTextColor(context),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Gap(12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 5.w,
                children: [
                  Expanded(child: _NoteTag(label: 'متابعة', color: AppColor.blueColor(context), isSelected: true)),
                 
                  Expanded(child: _NoteTag(label: 'عامة', color: AppColor.greyColor(context))),
                  
                  Expanded(child: _NoteTag(label: 'مهمة جداً', color: AppColor.redColor(context))),
                ],
              ),
              Gap(30.h),
              /// Bottom Action Bar
              CustomButton(
                radius: 12.r,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'حفظ الملاحظة',
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

class _NoteTag extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  const _NoteTag({required this.label, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? color : color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color.withOpacity(isSelected ? 1 : 0.3)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : color,
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}
