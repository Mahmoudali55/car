import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        centerTitle: true,
        title: Text(
          AppLocaleKey.changePassword.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.changePasswordStatus.isSuccess) {
            CommonMethods.showToast(
              message: AppLocaleKey.passwordChangedSuccessfully.tr(),
              type: ToastType.success,
            );
            Navigator.pop(context);
          }
          if (state.changePasswordStatus.isFailure) {
            CommonMethods.showToast(
              message: state.changePasswordStatus.error ?? 'Failed to change password',
              type: ToastType.error,
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FadeInDown(
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        AppLocaleKey.changeYourPassword.tr(),
                        style: AppTextStyle.titleLarge(context).copyWith(
                          color: AppColor.blackTextColor(context),
                          fontSize: 28.sp,
                        ),
                      ),
                    ),
                    Gap(8.h),
                    FadeInDown(
                      delay: const Duration(milliseconds: 200),
                      duration: const Duration(milliseconds: 800),
                      child: Text(
                        AppLocaleKey.enterYourCurrentAndNewPassword.tr(),
                        style: AppTextStyle.bodyLarge(context).copyWith(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                    Gap(40.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 800),
                      child: CustomFormField(
                        controller: cubit.currentPasswordController,
                        hintText: AppLocaleKey.currentPassword.tr(),
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
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return AppLocaleKey.pleaseEnterCurrentPassword.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 800),
                      child: CustomFormField(
                        controller: cubit.newPasswordController,
                        hintText: AppLocaleKey.newPassword.tr(),
                        isPassword: true,
                        prefixIcon: Icon(
                          Icons.lock_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: AppColor.textFormFillColor(context),
                        textStyle: TextStyle(color: AppColor.blackTextColor(context)),
                        hintStyle: TextStyle(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                        ),
                        radius: 16,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return AppLocaleKey.pleaseEnterNewPassword.tr();
                          }
                          if (value!.length < 6) {
                            return AppLocaleKey.passwordMustBeAtLeast6Characters.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 800),
                      child: CustomFormField(
                        controller: cubit.confirmPasswordController,
                        hintText: AppLocaleKey.confirmNewPassword.tr(),
                        isPassword: true,
                        prefixIcon: Icon(
                          Icons.lock_reset_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: AppColor.textFormFillColor(context),
                        textStyle: TextStyle(color: AppColor.blackTextColor(context)),
                        hintStyle: TextStyle(
                          color: AppColor.blackTextColor(context).withValues(alpha: 0.3),
                        ),
                        radius: 16,
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return AppLocaleKey.pleaseConfirmNewPassword.tr();
                          }
                          if (value != cubit.newPasswordController.text) {
                            return AppLocaleKey.passwordsDoNotMatch.tr();
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(40.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 800),
                      child: CustomButton(
                        onPressed: state.changePasswordStatus.isLoading
                            ? null
                            : () {
                                if (_formKey.currentState?.validate() ?? false) {
                                  cubit.changePassword();
                                }
                              },
                        child: state.changePasswordStatus.isLoading
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: CircularProgressIndicator(
                                  color: AppColor.whiteColor(context),
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                AppLocaleKey.changePassword.tr(),
                                style: AppTextStyle.bodyLarge(context).copyWith(
                                  color: AppColor.whiteColor(context),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}