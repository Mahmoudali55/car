import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:bot_toast/bot_toast.dart';

class ComplaintsScreen extends StatefulWidget {
  const ComplaintsScreen({super.key});

  @override
  State<ComplaintsScreen> createState() => _ComplaintsScreenState();
}

class _ComplaintsScreenState extends State<ComplaintsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _complaintController = TextEditingController();
  String? _selectedType;

  @override
  void dispose() {
    _complaintController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      if (_selectedType == null) {
        BotToast.showText(
          text: AppLocaleKey.selectComplaintType.tr(),
          duration: const Duration(seconds: 2),
        );
        return;
      }

      BotToast.showLoading();
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        BotToast.closeAllLoading();
        
        // Show success animation/dialog
        showDialog(
          context: context,
          builder: (context) => FadeInUp(
            child: AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
              backgroundColor: AppColor.cardColor(context),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.check_circle_rounded, color: Colors.green, size: 60.sp),
                  Gap(16.h),
                  Text(
                    AppLocaleKey.thankYouSupport.tr(),
                    style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Gap(20.h),
                  CustomButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      Navigator.pop(context); // Go back to support
                    },
                    text: AppLocaleKey.ok.tr(),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<String> complaintTypes = [
      AppLocaleKey.technicalIssue.tr(),
      AppLocaleKey.serviceIssue.tr(),
      AppLocaleKey.paymentIssue.tr(),
      AppLocaleKey.otherIssue.tr(),
    ];

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocaleKey.complaints.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  child: Text(
                    AppLocaleKey.officialInquiriesComplaints.tr(),
                    style: TextStyle(
                      color: AppColor.blackTextColor(context),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Gap(24.h),

                // COMPLAINT TYPE DROPDOWN
                FadeInLeft(
                  delay: const Duration(milliseconds: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocaleKey.complaintType.tr(),
                        style: AppTextStyle.formTitleStyle(context),
                      ),
                      Gap(8.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: AppColor.textFormFillColor(context),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: AppColor.textFormBorderColor(context)),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedType,
                            isExpanded: true,
                            hint: Text(
                              AppLocaleKey.selectComplaintType.tr(),
                              style: AppTextStyle.hintStyle(context),
                            ),
                            icon: Icon(Icons.keyboard_arrow_down_rounded, color: AppColor.hintColor(context)),
                            items: complaintTypes.map((String type) {
                              return DropdownMenuItem<String>(
                                value: type,
                                child: Text(type, style: AppTextStyle.textFormStyle(context)),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedType = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(20.h),

                // DESCRIPTION FIELD
                FadeInLeft(
                  delay: const Duration(milliseconds: 200),
                  child: CustomFormField(
                    controller: _complaintController,
                    title: AppLocaleKey.complaintDescription.tr(),
                    hintText: AppLocaleKey.feedbackHint.tr(),
                    maxLines: 6,
                    radius: 12.r,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return AppLocaleKey.validateEmpty.tr();
                      }
                      return null;
                    },
                  ),
                ),
                Gap(30.h),

                // SUBMIT BUTTON
                FadeInUp(
                  delay: const Duration(milliseconds: 300),
                  child: CustomButton(
                    onPressed: _submit,
                    text: AppLocaleKey.submitComplaint.tr(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
