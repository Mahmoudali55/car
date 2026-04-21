import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppColor.secondAppColor(context),
              AppColor.gradientSecondaryColor(context),
              AppColor.primaryColor(context).withOpacity(0.1),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(40.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 1000),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColor.blackTextColor(context),
                        ),
                        style: IconButton.styleFrom(
                          backgroundColor: AppColor.whiteColor(context).withOpacity((0.1)),
                          padding: EdgeInsets.all(12.w),
                        ),
                      ),
                    ),
                    Gap(30.h),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 1000),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocaleKey.createAccount.tr(),
                            style: AppTextStyle.titleLarge(
                              context,
                              color: AppColor.blackTextColor(context),
                            ).copyWith(fontSize: 32.sp),
                          ),
                          Gap(8.h),
                          Text(
                            AppLocaleKey.joinPremiumCommunity.tr(),
                            style: AppTextStyle.bodyMedium(
                              context,
                              color: AppColor.blackTextColor(context).withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(40.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomFormField(
                        controller:
                            TextEditingController(), // Placeholder, update with cubit if needed
                        hintText: AppLocaleKey.fullName.tr(),
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: AppColor.blackTextColor(context).withOpacity(0.05),
                        textStyle: TextStyle(color: AppColor.blackTextColor(context)),
                        hintStyle: TextStyle(
                          color: AppColor.blackTextColor(context).withOpacity(0.3),
                        ),
                        radius: 16,
                      ),
                    ),
                    Gap(20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomFormField(
                        controller: cubit.mobileController,
                        hintText: AppLocaleKey.mobileNumber.tr(),
                        prefixIcon: Icon(
                          Icons.phone_iphone_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: AppColor.blackTextColor(context).withOpacity(0.05),
                        textStyle: TextStyle(color: AppColor.blackTextColor(context)),
                        hintStyle: TextStyle(
                          color: AppColor.blackTextColor(context).withOpacity(0.3),
                        ),
                        radius: 16,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    Gap(20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomFormField(
                        controller: cubit.passwordController,
                        hintText: AppLocaleKey.password.tr(),
                        isPassword: true,
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: AppColor.blackTextColor(context).withOpacity(0.05),
                        textStyle: TextStyle(color: AppColor.blackTextColor(context)),
                        hintStyle: TextStyle(
                          color: AppColor.blackTextColor(context).withOpacity(0.3),
                        ),
                        radius: 16,
                      ),
                    ),
                    Gap(40.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomButton(
                        text: AppLocaleKey.signUp.tr(),
                        cubitState: cubit.state.loginStatus,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Register logic here
                          }
                        },
                      ),
                    ),
                    Gap(30.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 1000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocaleKey.alreadyHaveAccount.tr(),
                            style: AppTextStyle.bodyMedium(
                              context,
                              color: AppColor.blackTextColor(context).withOpacity(0.6),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              AppLocaleKey.login.tr(),
                              style: AppTextStyle.bodyLarge(
                                context,
                                color: AppColor.primaryColor(context),
                              ).copyWith(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
