import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/features/agent/presentation/screens/widget/note_tag_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
          AppLocaleKey.agentAddProfessionalNote.tr(),
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
                AppLocaleKey.agentAddNoteDesc.tr(),
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
                title: AppLocaleKey.agentTargetCustomer.tr(),
                hintText: AppLocaleKey.agentSearchRelevantCustomer.tr(),
                prefixIcon: const Icon(Icons.search_rounded),
              ),
              Gap(20.h),
               CustomFormField(
                radius:12.r,
                title: AppLocaleKey.agentNoteText.tr(),
                hintText: AppLocaleKey.agentWriteNoteHint.tr(),
                prefixIcon: const Icon(Icons.edit_note_rounded),
                maxLines: 6,
              ),
              Gap(24.h),
                  
              /// Category Selection Mock
              Text(
                AppLocaleKey.agentNoteClassification.tr(),
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
                  Expanded(child: NoteTag(label: AppLocaleKey.agentFollowUp.tr(), color: AppColor.blueColor(context), isSelected: true)),
                  Expanded(child: NoteTag(label: AppLocaleKey.agentGeneral.tr(), color: AppColor.greyColor(context))),
                  Expanded(child: NoteTag(label: AppLocaleKey.agentVeryImportant.tr(), color: AppColor.redColor(context))),
                ],
              ),
              Gap(30.h),
              /// Bottom Action Bar
              CustomButton(
                radius: 12.r,
                onPressed: () => Navigator.pop(context),
                child: Text(
                  AppLocaleKey.agentSaveNote.tr(),
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

