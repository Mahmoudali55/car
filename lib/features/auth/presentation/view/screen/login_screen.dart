import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
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
              AppColor.primaryColor(context).withValues(alpha: 0.1),
            ],
          ),
        ),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state.loginStatus.isSuccess) {
              CommonMethods.showToast(message: state.loginStatus.data?.message ?? 'Login success');
              if (HiveMethods.getRole() == 'admin') {
                NavigatorMethods.pushReplacementNamed(context, RoutesName.adminDashboard);
              } else {
                NavigatorMethods.pushReplacementNamed(context, RoutesName.mainLayout);
              }
            }
            if (state.loginStatus.isFailure) {
              log(state.loginStatus.error?.toString() ?? 'Login failed');
              final error = state.loginStatus.error ?? 'Login failed';
              CommonMethods.showToast(message: error, type: ToastType.error);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 60.h),
                        FadeInDown(
                          duration: const Duration(milliseconds: 1500),
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.all(20.w),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primaryColor(context).withValues(alpha: 0.2),
                                    blurRadius: 30,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.directions_car_filled_rounded,
                                size: 60.w,
                                color: AppColor.whiteColor(context),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40.h),
                        FadeInLeft(
                          duration: const Duration(milliseconds: 1000),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocaleKey.welcomeBack.tr(),
                                style: AppTextStyle.titleLarge(
                                  context,
                                  color: AppColor.blackTextColor(context),
                                ).copyWith(fontSize: 32.sp),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                AppLocaleKey.loginToContinueYourPremiumExperience.tr(),
                                style: AppTextStyle.bodyLarge(
                                  context,
                                  color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 200),
                          duration: const Duration(milliseconds: 1000),
                          child: CustomFormField(
                            controller: cubit.mobileController,
                            hintText: AppLocaleKey.mobileNumber.tr(),
                            prefixIcon: Icon(
                              Icons.phone_iphone_rounded,
                              color: AppColor.primaryColor(context),
                            ),
                            fillColor: AppColor.textFormFillColor(context),
                            textStyle: TextStyle(color: AppColor.blackTextColor(context)),
                            hintStyle: TextStyle(
                              color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                            ),
                            radius: 16,
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 400),
                          duration: const Duration(milliseconds: 1000),
                          child: CustomFormField(
                            controller: cubit.passwordController,
                            hintText: AppLocaleKey.password.tr(),
                            isPassword: true,
                            prefixIcon: Icon(
                              Icons.lock_outline_rounded,
                              color: AppColor.primaryColor(context),
                            ),
                            fillColor: AppColor.textFormFillColor(context),
                            textStyle: TextStyle(color: AppColor.blackTextColor(context)),
                            hintStyle: TextStyle(
                              color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                            ),
                            radius: 16,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          duration: const Duration(milliseconds: 1000),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                    width: 24.h,
                                    child: Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor: AppColor.blackTextColor(
                                          context,
                                        ).withValues(alpha: 0.3),
                                      ),
                                      child: Checkbox(
                                        value: cubit.rememberMe,
                                        activeColor: AppColor.primaryColor(context),
                                        checkColor: AppColor.whiteColor(context),
                                        onChanged: (value) => cubit.changeRememberMe(),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    AppLocaleKey.rememberMe.tr(),
                                    style: AppTextStyle.bodySmall(
                                      context,
                                      color: AppColor.blackTextColor(context),
                                    ),
                                  ),
                                ],
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  AppLocaleKey.forgotPassword.tr(),
                                  style: AppTextStyle.bodyMedium(
                                    context,
                                    color: AppColor.primaryColor(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 600),
                          duration: const Duration(milliseconds: 1000),
                          child: Column(
                            children: [
                              CustomButton(
                                text: AppLocaleKey.login.tr(),
                                cubitState: cubit.state.loginStatus,
                                onPressed: () {
                                  if (cubit.mobileController.text == '999' &&
                                      cubit.passwordController.text == 'admin') {
                                    HiveMethods.updateIsGuest(false);
                                    HiveMethods.updateToken('admin_dummy_token');
                                    HiveMethods.updateRole('admin');
                                    CommonMethods.showToast(
                                      message: 'تم تسجيل الدخول بصلاحية الأدمن',
                                    );
                                    NavigatorMethods.pushReplacementNamed(
                                      context,
                                      RoutesName.adminDashboard,
                                    );
                                  } else {
                                    cubit.login();
                                  }
                                },
                              ),
                              SizedBox(height: 15.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      HiveMethods.updateIsGuest(true);
                                      NavigatorMethods.pushReplacementNamed(
                                        context,
                                        RoutesName.mainLayout,
                                      );
                                    },
                                    child: Text(
                                      AppLocaleKey.continueAsGuest.tr(),
                                      style: AppTextStyle.bodyLarge(
                                        context,
                                        color: AppColor.blackTextColor(context),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 1,
                                    height: 20.h,
                                    color: AppColor.blackTextColor(context).withValues(alpha: 0.2),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      HiveMethods.updateIsGuest(false);
                                      HiveMethods.updateToken('admin_dummy_token');
                                      HiveMethods.updateRole('admin');
                                      CommonMethods.showToast(message: 'تم تسجيل الدخول كمدير');
                                      NavigatorMethods.pushReplacementNamed(
                                        context,
                                        RoutesName.adminDashboard,
                                      );
                                    },
                                    child: Text(
                                      'دخول كمسؤول (Admin)',
                                      style: AppTextStyle.bodyLarge(
                                        context,
                                        color: AppColor.primaryColor(context),
                                      ).copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40.h),
                        FadeInUp(
                          delay: const Duration(milliseconds: 800),
                          duration: const Duration(milliseconds: 1000),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppLocaleKey.dontHaveAccount.tr(),
                                style: AppTextStyle.bodyMedium(
                                  context,
                                  color: AppColor.blackTextColor(context),
                                ),
                              ),
                              TextButton(
                                onPressed: () =>
                                    NavigatorMethods.pushNamed(context, RoutesName.registerScreen),
                                child: Text(
                                  AppLocaleKey.signUp.tr(),
                                  style: AppTextStyle.bodyLarge(
                                    context,
                                    color: AppColor.primaryColor(context),
                                  ).copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
