import 'package:animate_do/animate_do.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

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
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: AppColor.whiteColor(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                AppLocaleKey.supportCenter.tr(),
                style: AppTextStyle.titleMedium(context).copyWith(
                  color: AppColor.whiteColor(context),
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF4C1D95), Color(0xFF1E1E2C)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: Opacity(
                    opacity: 0.1,
                    child: Icon(
                      Icons.support_agent_rounded,
                      size: 120.sp,
                      color: AppColor.whiteColor(context),
                    ),
                  ),
                ),
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
                    child: Text(
                      AppLocaleKey.howCanWeHelp.tr(),
                      style: TextStyle(
                        color: AppColor.whiteColor(context),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap(20.h),
                  _buildSupportCard(
                    context,
                    title: AppLocaleKey.chatWithUs.tr(),
                    subtitle: AppLocaleKey.whatsappFastAccess.tr(),
                    icon: Icons.chat_bubble_rounded,
                    color: Colors.greenAccent,
                    index: 0,
                  ),
                  _buildSupportCard(
                    context,
                    title: AppLocaleKey.callUs.tr(),
                    subtitle: AppLocaleKey.customerService247.tr(),
                    icon: Icons.phone_in_talk_rounded,
                    color: Colors.blueAccent,
                    index: 1,
                  ),
                  _buildSupportCard(
                    context,
                    title: AppLocaleKey.email.tr(),
                    subtitle: AppLocaleKey.officialInquiriesComplaints.tr(),
                    icon: Icons.alternate_email_rounded,
                    color: Colors.orangeAccent,
                    index: 2,
                  ),
                  Gap(30.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      AppLocaleKey.faqs.tr(),
                      style: TextStyle(
                        color: AppColor.whiteColor(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap(12.h),
                  _buildFAQItem(AppLocaleKey.faqOrderStatus.tr()),
                  _buildFAQItem(AppLocaleKey.faqPaymentMethods.tr()),
                  _buildFAQItem(AppLocaleKey.faqCancelAppointment.tr()),
                  Gap(50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required int index,
  }) {
    return FadeInUp(
      delay: Duration(milliseconds: 100 * index),
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: AppColor.whiteColor(context).withValues(alpha: (0.05)),
          ),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          leading: Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: color.withValues(alpha: (0.1)),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: color, size: 24.sp),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: AppColor.whiteColor(context),
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: const TextStyle(color: Colors.white38, fontSize: 11),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios_rounded,
            color: Colors.white24,
            size: 16,
          ),
          onTap: () {},
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1F2937).withValues(alpha: (0.5)),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              question,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
            const Icon(Icons.add_rounded, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}
