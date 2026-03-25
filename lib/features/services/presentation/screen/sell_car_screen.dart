import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SellCarScreen extends StatelessWidget {
  const SellCarScreen({super.key});

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
            backgroundColor: AppColor.scaffoldColor(context),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                AppLocaleKey.sellYourCarTitle.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF111827), Color(0xFF1F2937)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  Positioned(
                    right: -20.w,
                    bottom: -10.h,
                    child: Opacity(
                      opacity: 0.1,
                      child: Image.asset(
                        'assets/images/cars/aston-martin.png',
                        height: 180.h,
                        fit: BoxFit.contain,
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
                  FadeInUp(child: _buildSectionHeader(AppLocaleKey.listCarForSale.tr())),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: _buildTextField(AppLocaleKey.brandAndModel.tr()),
                  ),
                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: _buildTextField(AppLocaleKey.askingPrice.tr()),
                  ),
                  Gap(12.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 300),
                    child: _buildTextField(AppLocaleKey.contactNumber.tr()),
                  ),
                  Gap(32.h),
                  FadeInUp(child: _buildSectionHeader(AppLocaleKey.carImages.tr())),
                  Gap(16.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Container(
                      height: 120.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF1F2937),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.05),
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_rounded, color: Colors.white38, size: 40.sp),
                          Gap(8.h),
                          Text(
                            AppLocaleKey.pressToAddPhotos.tr(),
                            style: const TextStyle(color: Colors.white38),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Gap(40.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 500),
                    child: _buildSubmitButton(context, AppLocaleKey.confirmListing.tr()),
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

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildTextField(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white38, fontSize: 14.sp),
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildSubmitButton(BuildContext context, String text) {
    return Container(
      width: double.infinity,
      height: 55.h,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16.r)),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
