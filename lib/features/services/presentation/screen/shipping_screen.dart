import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ShippingScreen extends StatefulWidget {
  const ShippingScreen({super.key});

  @override
  State<ShippingScreen> createState() => _ShippingScreenState();
}

class _ShippingScreenState extends State<ShippingScreen> {
  String? selectedTruck;

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
                AppLocaleKey.vipCarShipping.tr(),
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
                        colors: [Color(0xFF4C1D95), Color(0xFF7C3AED)],
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
                        Icons.local_shipping_rounded,
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
                  FadeInUp(child: _buildSectionHeader(AppLocaleKey.shippingDetails.tr(), context)),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: _buildTextField(AppLocaleKey.departurePoint.tr(), context),
                  ),
                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildTextField(AppLocaleKey.arrivalDestination.tr(), context),
                  ),
                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: _buildTextField(AppLocaleKey.preferredShippingDate.tr(), context),
                  ),
                  Gap(32.h),
                  FadeInUp(child: _buildSectionHeader(AppLocaleKey.truckType.tr(), context)),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: GestureDetector(
                      onTap: () => setState(() => selectedTruck = AppLocaleKey.openFlatbed.tr()),
                      child: _buildSelectionCard(
                        AppLocaleKey.openFlatbed.tr(),
                        context,
                        isSelected: selectedTruck == AppLocaleKey.openFlatbed.tr(),
                      ),
                    ),
                  ),

                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => selectedTruck = AppLocaleKey.closedCarrierVip.tr()),
                      child: _buildSelectionCard(
                        AppLocaleKey.closedCarrierVip.tr(),
                        context,
                        isSelected: selectedTruck == AppLocaleKey.closedCarrierVip.tr(),
                      ),
                    ),
                  ),

                  Gap(40.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 600),
                    child: _buildSubmitButton(context, AppLocaleKey.bookShipment.tr()),
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
            child: Text(
              AppLocaleKey.ok.tr(),
              style: TextStyle(color: AppColor.primaryColor(context)),
            ),
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
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: (0.05))),
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
        gradient: const LinearGradient(colors: [Color(0xFF4C1D95), Color(0xFF7C3AED)]),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C1D95).withValues(alpha: (0.3)),
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
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(color: AppColor.whiteColor(context), fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
