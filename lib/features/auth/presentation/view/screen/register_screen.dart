import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
              const Color(0xff161B22),
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
                    SizedBox(height: 40.h),
                    FadeInDown(
                      duration: const Duration(milliseconds: 1000),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.1),
                          padding: EdgeInsets.all(12.w),
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    FadeInLeft(
                      duration: const Duration(milliseconds: 1000),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Account',
                            style: AppTextStyle.titleLarge(
                              context,
                              color: Colors.white,
                            ).copyWith(fontSize: 32.sp),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            'Join our premium automotive community',
                            style: AppTextStyle.bodyMedium(
                              context,
                              color: Colors.white.withOpacity(0.6),
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
                        controller:
                            TextEditingController(), // Placeholder, update with cubit if needed
                        hintText: 'Full Name',
                        prefixIcon: Icon(
                          Icons.person_outline_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: Colors.white.withOpacity(0.05),
                        textStyle: const TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        radius: 16,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 400),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomFormField(
                        controller: cubit.mobileController,
                        hintText: 'Mobile Number',
                        prefixIcon: Icon(
                          Icons.phone_iphone_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: Colors.white.withOpacity(0.05),
                        textStyle: const TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        radius: 16,
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 600),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomFormField(
                        controller: cubit.passwordController,
                        hintText: 'Password',
                        isPassword: true,
                        prefixIcon: Icon(
                          Icons.lock_outline_rounded,
                          color: AppColor.primaryColor(context),
                        ),
                        fillColor: Colors.white.withOpacity(0.05),
                        textStyle: const TextStyle(color: Colors.white),
                        hintStyle: TextStyle(color: Colors.white.withOpacity(0.3)),
                        radius: 16,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 800),
                      duration: const Duration(milliseconds: 1000),
                      child: CustomButton(
                        text: "Sign Up",
                        cubitState: cubit.state.loginStatus,
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Register logic here
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 30.h),
                    FadeInUp(
                      delay: const Duration(milliseconds: 1000),
                      duration: const Duration(milliseconds: 1000),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have an account? ',
                            style: AppTextStyle.bodyMedium(
                              context,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              'Login',
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
        ),
      ),
    );
  }
}
