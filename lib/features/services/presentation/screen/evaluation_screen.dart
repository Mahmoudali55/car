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

class EvaluationScreen extends StatefulWidget {
  const EvaluationScreen({super.key});

  @override
  State<EvaluationScreen> createState() => _EvaluationScreenState();
}

class _EvaluationScreenState extends State<EvaluationScreen> {
  int _rating = 0;
  final _feedbackController = TextEditingController();

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_rating == 0) {
      BotToast.showText(
        text: context.locale.languageCode == 'ar' ? 'يرجى اختيار التقييم' : 'Please select a rating',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    BotToast.showLoading();
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      BotToast.closeAllLoading();
      
      showDialog(
        context: context,
        builder: (context) => FadeInUp(
          child: AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            backgroundColor: AppColor.cardColor(context),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.stars_rounded, color: Colors.amber, size: 60.sp),
                Gap(16.h),
                Text(
                  AppLocaleKey.evaluationSuccess.tr(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppLocaleKey.serviceEvaluation.tr(),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FadeInDown(
                child: Text(
                  AppLocaleKey.ratingTitle.tr(),
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Gap(30.h),

              // STAR RATING
              FadeInUp(
                delay: const Duration(milliseconds: 100),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2.w),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _rating = index + 1;
                            });
                          },
                          borderRadius: BorderRadius.circular(50.r),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.all(6.w),
                            child: Icon(
                              index < _rating ? Icons.star_rounded : Icons.star_outline_rounded,
                              color: index < _rating ? Colors.amber : AppColor.hintColor(context),
                              size: 40.sp,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
              Gap(40.h),

              // FEEDBACK FIELD
              FadeInLeft(
                delay: const Duration(milliseconds: 200),
                child: CustomFormField(
                  controller: _feedbackController,
                  title: AppLocaleKey.feedbackHint.tr(),
                  hintText: AppLocaleKey.feedbackHint.tr(),
                  maxLines: 5,
                  radius: 12.r,
                ),
              ),
              Gap(40.h),

              // SUBMIT BUTTON
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: CustomButton(
                  onPressed: _submit,
                  text: AppLocaleKey.submitEvaluation.tr(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
