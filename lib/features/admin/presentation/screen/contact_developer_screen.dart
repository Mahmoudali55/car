import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ContactDeveloperScreen extends StatelessWidget {
  const ContactDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.contactDeveloper.tr())),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactHeader(context),
            Gap(32.h),
            _buildTicketForm(context),
            Gap(40.h),
            _buildDirectLiaison(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContactHeader(BuildContext context) {
    return FadeInDown(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocaleKey.technicalSupportTicket.tr(),
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
            ),
          ),
          Gap(8.h),
          Text(
            "Report bugs, request features, or ask technical questions directly to the development team.",
            style: TextStyle(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTicketForm(BuildContext context) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: baseColor.withValues(alpha: 0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFieldLabel(context, AppLocaleKey.issueType.tr()),
            _buildDropdownField(context, "Select category..."),
            Gap(20.h),
            _buildFieldLabel(context, AppLocaleKey.subject.tr()),
            _buildTextField(context, "Brief summary of the issue..."),
            Gap(20.h),
            _buildFieldLabel(context, AppLocaleKey.description.tr()),
            _buildTextField(context, "Provide detailed information...", maxLines: 5),
            Gap(24.h),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColor.primaryColor(context),
                minimumSize: Size(double.infinity, 56.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                elevation: 0,
              ),
              child: Text(
                AppLocaleKey.submitTicket.tr(),
                style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldLabel(BuildContext context, String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Text(
        label,
        style: TextStyle(
          color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.2), fontSize: 13.sp),
        filled: true,
        fillColor: AppColor.scaffoldColor(context),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.blackTextColor(context).withValues(alpha: 0.1)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColor.primaryColor(context)),
        ),
      ),
    );
  }

  Widget _buildDropdownField(BuildContext context, String hint) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          hint: Text(hint, style: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.2), fontSize: 13.sp)),
          items: const [],
          onChanged: (val) {},
        ),
      ),
    );
  }

  Widget _buildDirectLiaison(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 400),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.primaryColor(context).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.1)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(color: AppColor.primaryColor(context).withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(Icons.rocket_launch_rounded, color: AppColor.primaryColor(context), size: 24.sp),
            ),
            Gap(20.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocaleKey.priorityLiaison.tr(),
                    style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Administrative tickets are handled with high priority.",
                    style: TextStyle(color: AppColor.blackTextColor(context).withValues(alpha: 0.5), fontSize: 11.sp),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
