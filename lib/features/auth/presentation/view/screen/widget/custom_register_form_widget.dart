import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomRegisterFormWidget extends StatelessWidget {
  const CustomRegisterFormWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.cubit,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final AuthCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Gap(50.h),
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
                  ).copyWith(),
                ),
                Gap(8.h),
                Text(
                  AppLocaleKey.joinPremiumCommunity.tr(),
                  style: AppTextStyle.bodyMedium(
                    context,
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
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
              controller: cubit.fullNameController,
              hintText: AppLocaleKey.fullName.tr(),
              prefixIcon: Icon(Icons.person_outline_rounded, color: AppColor.primaryColor(context)),
              fillColor: AppColor.blackTextColor(context).withValues(alpha: 0.05),
              textStyle: TextStyle(color: AppColor.blackTextColor(context)),
              hintStyle: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.3)),
              radius: 16,
              keyboardType: TextInputType.name,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  return AppLocaleKey.fullNameRequired.tr();
                }
                return null;
              },
            ),
          ),
          Gap(20.h),
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            duration: const Duration(milliseconds: 1000),
            child: CustomFormField(
              controller: cubit.emailController,
              hintText: AppLocaleKey.email.tr(),
              prefixIcon: Icon(Icons.email_outlined, color: AppColor.primaryColor(context)),
              fillColor: AppColor.blackTextColor(context).withValues(alpha: 0.05),
              textStyle: TextStyle(color: AppColor.blackTextColor(context)),
              hintStyle: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.3)),
              radius: 16,
              keyboardType: TextInputType.emailAddress,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  return AppLocaleKey.emailRequired.tr();
                }
                return null;
              },
            ),
          ),
          Gap(20.h),
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            duration: const Duration(milliseconds: 1000),
            child: CustomFormField(
              controller: cubit.idNoController,
              hintText: AppLocaleKey.phoneNumber.tr(),
              prefixIcon: Icon(Icons.phone, color: AppColor.primaryColor(context)),
              fillColor: AppColor.blackTextColor(context).withValues(alpha: 0.05),
              textStyle: TextStyle(color: AppColor.blackTextColor(context)),
              hintStyle: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.3)),
              radius: 16,
              keyboardType: TextInputType.number,
              maxLength: 10,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  return AppLocaleKey.idNumberRequired.tr();
                }
                return null;
              },
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
              prefixIcon: Icon(Icons.lock_outline_rounded, color: AppColor.primaryColor(context)),
              fillColor: AppColor.blackTextColor(context).withValues(alpha: 0.05),
              textStyle: TextStyle(color: AppColor.blackTextColor(context)),
              hintStyle: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.3)),
              radius: 16,
              validator: (p0) {
                if (p0 == null || p0.trim().isEmpty) {
                  return AppLocaleKey.passwordRequired.tr();
                }
                return null;
              },
            ),
          ),
          Gap(40.h),
          FadeInUp(
            delay: const Duration(milliseconds: 800),
            duration: const Duration(milliseconds: 1000),
            child: CustomButton(
              radius: 12.r,
              text: AppLocaleKey.signUp.tr(),
              cubitState: cubit.state.registerStatus,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  cubit.register();
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
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
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
    );
  }
}
