import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AddCarScreen extends StatelessWidget {
  const AddCarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
        ),
        title: Text(
          AppLocaleKey.addLuxuryCar.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(child: _buildImageUpload(context)),
            Gap(32.h),
            FadeInUp(
              delay: const Duration(milliseconds: 200),
              child: Column(
                children: [
                  _buildSectionTitle(AppLocaleKey.basicInfo.tr(), context),
                  Gap(16.h),
                  _buildGlassField(AppLocaleKey.carNameModel.tr(), context),
                  Gap(16.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildGlassField(
                          '${AppLocaleKey.price.tr()} (${AppLocaleKey.aed.tr()})',
                          context,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Gap(16.w),
                      Expanded(
                        child: _buildGlassField(
                          AppLocaleKey.manufacturingYear.tr(),
                          context,
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),
                  Gap(16.h),
                  _buildGlassField(AppLocaleKey.carDescriptionDetail.tr(), context, maxLines: 4),
                  Gap(32.h),
                  _buildSectionTitle(AppLocaleKey.technicalSpecs.tr(), context),
                  Gap(16.h),
                  Row(
                    children: [
                      Expanded(child: _buildGlassField(AppLocaleKey.engine.tr(), context)),
                      Gap(16.w),
                      Expanded(child: _buildGlassField(AppLocaleKey.status.tr(), context)),
                    ],
                  ),
                  Gap(40.h),
                  CustomButton(text: AppLocaleKey.confirmAddCar.tr(), onPressed: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: TextStyle(
          color: AppColor.blackTextColor(context).withOpacity(0.5),
          fontSize: 13.sp,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildGlassField(
    String hint,
    BuildContext context, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withOpacity(0.03),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
          ),
          child: TextField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            style: TextStyle(color: AppColor.blackTextColor(context)),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: AppColor.blackTextColor(context).withOpacity(0.2),
                fontSize: 13.sp,
              ),
              contentPadding: EdgeInsets.all(20.w),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageUpload(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          height: 200.h,
          decoration: BoxDecoration(
            color: AppColor.blackTextColor(context).withOpacity(0.04),
            borderRadius: BorderRadius.circular(32.r),
            border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.1)),
          ),
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl:
                    'https://images.unsplash.com/photo-1583121274602-3e2820c69888?q=80&w=1000', // Better Car URL
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.6),
                colorBlendMode: BlendMode.darken,
                placeholder: (context, url) =>
                    Container(color: AppColor.blackTextColor(context).withOpacity(0.05)),
                errorWidget: (context, url, error) => Container(
                  color: AppColor.blackTextColor(context).withOpacity(0.05),
                  child: Icon(
                    Icons.error_outline,
                    color: AppColor.blackTextColor(context).withOpacity(0.2),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: AppColor.blackTextColor(context).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.add_photo_alternate_outlined,
                        color: AppColor.blackTextColor(context),
                        size: 32.sp,
                      ),
                    ),
                    Gap(12.h),
                    Text(
                      AppLocaleKey.clickToAddCarImages.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      AppLocaleKey.transparentBgHint.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context).withOpacity(0.4),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
