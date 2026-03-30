import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarDetailingScreen extends StatefulWidget {
  const CarDetailingScreen({super.key});

  @override
  State<CarDetailingScreen> createState() => _CarDetailingScreenState();
}

class _CarDetailingScreenState extends State<CarDetailingScreen> {
  String? selectedService;

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
                AppLocaleKey.carePolishingServices.tr(),
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
                        colors: [Color(0xFF831843), Color(0xFFBE185D)],
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
                        Icons.auto_awesome_rounded,
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
                  FadeInUp(
                    child: _buildSectionHeader(AppLocaleKey.requestedServiceType.tr(), context),
                  ),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: GestureDetector(
                      onTap: () => setState(
                        () => selectedService = AppLocaleKey.comprehensiveExteriorPolishing.tr(),
                      ),
                      child: _buildSelectionCard(
                        AppLocaleKey.comprehensiveExteriorPolishing.tr(),
                        context,
                        isSelected:
                            selectedService == AppLocaleKey.comprehensiveExteriorPolishing.tr(),
                      ),
                    ),
                  ),

                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: GestureDetector(
                      onTap: () => setState(
                        () => selectedService = AppLocaleKey.interiorCleaningPolishing.tr(),
                      ),
                      child: _buildSelectionCard(
                        AppLocaleKey.interiorCleaningPolishing.tr(),
                        context,
                        isSelected: selectedService == AppLocaleKey.interiorCleaningPolishing.tr(),
                      ),
                    ),
                  ),

                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => selectedService = AppLocaleKey.nanoCeramicProtection.tr()),
                      child: _buildSelectionCard(
                        AppLocaleKey.nanoCeramicProtection.tr(),
                        context,
                        isSelected: selectedService == AppLocaleKey.nanoCeramicProtection.tr(),
                      ),
                    ),
                  ),

                  Gap(32.h),
                  FadeInUp(child: _buildSectionHeader(AppLocaleKey.carDetails.tr(), context)),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: _buildTextField(AppLocaleKey.carSizeHint.tr(), context),
                  ),
                  Gap(40.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: _buildSubmitButton(context, AppLocaleKey.bookAppointment.tr()),
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

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.secondAppColor(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Icon(Icons.check_circle_outline_rounded, color: Colors.green, size: 60.sp),
        content: Text(
          AppLocaleKey.requestSubmittedSuccess.tr(),
          textAlign: TextAlign.center,
          style: AppTextStyle.bodyMedium(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // close dialog
              Navigator.pop(context); // go back
            },
            child: Text(AppLocaleKey.ok.tr(), style: TextStyle(color: AppColor.primaryColor(context))),
          ),
        ],
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

  Widget _buildSelectionCard(String title, BuildContext context, {required bool isSelected}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColor.primaryColor(context).withValues(alpha: 0.1)
            : AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected
              ? AppColor.primaryColor(context)
              : AppColor.blackTextColor(context).withValues(alpha: 0.05),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? AppColor.primaryColor(context) : AppColor.blackTextColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
            color: isSelected
                ? AppColor.primaryColor(context)
                : AppColor.blackTextColor(context).withValues(alpha: 0.24),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF831843), Color(0xFFBE185D)]),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF831843).withValues(alpha: (0.3)),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _showSuccessDialog(context),
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
