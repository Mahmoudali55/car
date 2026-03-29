import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FinancingScreen extends StatelessWidget {
  const FinancingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 180.h,
            pinned: true,
            backgroundColor: AppColor.appBarColor(context),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.whiteColor(context)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                AppLocaleKey.financingSolutions.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF92400E), Color(0xFFD97706)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20.w,
                    bottom: -10.h,
                    child: Opacity(
                      opacity: 0.2,
                      child: Icon(
                        Icons.account_balance_wallet_rounded,
                        size: 150.sp,
                        color: AppColor.blackTextColor(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInUp(child: _buildSectionHeader(AppLocaleKey.financingInfo.tr(), context)),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: _buildTextField(AppLocaleKey.approxCarValue.tr(), context),
                  ),
                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildTextField(AppLocaleKey.availableDownPayment.tr(), context),
                  ),
                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: _buildTextField(AppLocaleKey.financingDurationYears.tr(), context),
                  ),
                  Gap(32.h),
                  FadeInUp(child: _buildSectionHeader(AppLocaleKey.personalInfo.tr(), context)),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: _buildTextField(AppLocaleKey.workPlace.tr(), context),
                  ),
                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: _buildTextField(AppLocaleKey.approxMonthlySalary.tr(), context),
                  ),
                  Gap(40.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: _buildSubmitButton(context, AppLocaleKey.submitFinancingRequest.tr()),
                  ),
                  Gap(50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: AppColor.blackTextColor(context),
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(String hint, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: CustomFormField(hintText: hint),
    );
  }

  Widget _buildSubmitButton(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF92400E), Color(0xFFD97706)]),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF92400E).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColor.whiteColor(context),
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
