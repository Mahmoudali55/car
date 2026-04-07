import 'package:animate_do/animate_do.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/services/presentation/screen/complaints_screen.dart';
import 'package:car/features/services/presentation/screen/evaluation_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
            backgroundColor: AppColor.appBarColor(context),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context)),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                AppLocaleKey.supportCenter.tr(),
                style: AppTextStyle.titleMedium(
                  context,
                ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.bold),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.primaryColor(context),
                      AppColor.primaryColor(context).withValues(alpha: 0.8),
                    ],
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
                      color: AppColor.blackTextColor(context),
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
                        color: AppColor.blackTextColor(context),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap(8.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 100),
                    child: Text(
                      AppLocaleKey.slogan.tr(),
                      style: TextStyle(
                        color: AppColor.primaryColor(context),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Gap(24.h),

                  // COMPLAINTS & EVALUATION CARDS
                  Row(
                    children: [
                      Expanded(
                        child: FadeInLeft(
                          delay: const Duration(milliseconds: 200),
                          child: _buildActionCard(
                            context,
                            AppLocaleKey.complaints.tr(),
                            Icons.report_problem_rounded,
                            const Color(0xFFFEE2E2),
                            const Color(0xFFDC2626),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ComplaintsScreen()),
                            ),
                          ),
                        ),
                      ),
                      Gap(12.w),
                      Expanded(
                        child: FadeInRight(
                          delay: const Duration(milliseconds: 200),
                          child: _buildActionCard(
                            context,
                            AppLocaleKey.serviceEvaluation.tr(),
                            Icons.star_rate_rounded,
                            const Color(0xFFFEF3C7),
                            const Color(0xFFD97706),
                            () => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const EvaluationScreen()),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(24.h),

                  // GENERAL CONTACT
                  _buildSectionHeader(
                    context,
                    AppLocaleKey.landlineAndWhatsapp.tr(),
                    Icons.phone_android_rounded,
                  ),
                  _buildContactItem(context, '0112311114', Icons.headset_mic_rounded),
                  Gap(20.h),

                  _buildSectionHeader(context, AppLocaleKey.emails.tr(), Icons.email_rounded),
                  _buildContactItem(context, 'info@binwazir.com', Icons.alternate_email_rounded),
                  _buildContactItem(context, 'media@binwazir.com', Icons.alternate_email_rounded),
                  Gap(20.h),

                  // MANAGEMENT
                  _buildSectionHeader(
                    context,
                    AppLocaleKey.management.tr(),
                    Icons.admin_panel_settings_rounded,
                  ),
                  _buildContactItem(context, '0550266666', Icons.phone_iphone_rounded),
                  Gap(20.h),

                  // INSTALLMENT SALES
                  _buildSectionHeader(
                    context,
                    AppLocaleKey.installmentSales.tr(),
                    Icons.account_balance_wallet_rounded,
                  ),
                  _buildContactItem(context, '0548272279', Icons.phone_iphone_rounded),
                  _buildContactItem(context, '0564169376', Icons.phone_iphone_rounded),
                  _buildContactItem(context, '0562012761', Icons.phone_iphone_rounded),
                  Gap(20.h),

                  // CASH SALES
                  _buildSectionHeader(context, AppLocaleKey.cashSales.tr(), Icons.payments_rounded),
                  _buildContactItem(context, '0501239318', Icons.phone_iphone_rounded),
                  _buildContactItem(context, '0557955538', Icons.phone_iphone_rounded),
                  _buildContactItem(context, '0559726744', Icons.phone_iphone_rounded),
                  _buildContactItem(context, '0564169370', Icons.phone_iphone_rounded),
                  _buildContactItem(context, '0504335378', Icons.phone_iphone_rounded),
                  _buildContactItem(context, '0562012761', Icons.phone_iphone_rounded),

                  Gap(30.h),
                  FadeInUp(
                    delay: const Duration(milliseconds: 400),
                    child: Text(
                      AppLocaleKey.faqs.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Gap(12.h),
                  _buildFAQItem(AppLocaleKey.faqOrderStatus.tr(), context),
                  _buildFAQItem(AppLocaleKey.faqPaymentMethods.tr(), context),
                  _buildFAQItem(AppLocaleKey.faqCancelAppointment.tr(), context),
                  Gap(50.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title, IconData icon) {
    return FadeInLeft(
      child: Padding(
        padding: EdgeInsets.only(bottom: 12.h),
        child: Row(
          children: [
            Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
            Gap(8.w),
            Text(
              title,
              style: TextStyle(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.9),
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, String value, IconData icon) {
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
        ),
        child: ListTile(
          dense: true,
          leading: Icon(
            icon,
            color: AppColor.blackTextColor(context).withValues(alpha: 0.6),
            size: 18.sp,
          ),
          title: Text(
            value,
            style: TextStyle(
              color: AppColor.blackTextColor(context),
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          trailing: Icon(
            Icons.copy_rounded,
            color: AppColor.blackTextColor(context).withValues(alpha: 0.2),
            size: 16.sp,
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: value));
            BotToast.showText(
              text: context.locale.languageCode == 'ar' ? 'تم النسخ' : 'Copied',
              duration: const Duration(seconds: 2),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              question,
              style: TextStyle(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.70),
                fontSize: 13,
              ),
            ),
            Icon(
              Icons.add_rounded,
              color: AppColor.blackTextColor(context).withValues(alpha: 0.24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    String title,
    IconData icon,
    Color bgColor,
    Color iconColor,
    VoidCallback onTap,
  ) {
    final isDark = !AppColor.isLight(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 12.w),
        decoration: BoxDecoration(
          color: isDark ? AppColor.secondAppColor(context) : bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: isDark ? AppColor.borderColor(context) : Colors.transparent),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: isDark ? iconColor.withValues(alpha: 0.1) : iconColor.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 24.sp),
            ),
            Gap(12.h),
            Text(
              title,
              style: TextStyle(
                color: isDark ? AppColor.blackTextColor(context) : iconColor.withValues(alpha: 0.2),
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
