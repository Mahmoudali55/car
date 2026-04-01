import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SystemAlertsScreen extends StatelessWidget {
  const SystemAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.systemAlerts.tr())),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAlertsPromo(context),
            Gap(32.h),
            _buildAlertSection(context, AppLocaleKey.notificationChannels.tr(), [
              _buildAlertToggle(
                context,
                Icons.mark_email_unread_rounded,
                AppLocaleKey.emailNotifications.tr(),
                AppLocaleKey.emailNotificationsDesc.tr(),
                true,
              ),
              _buildAlertToggle(
                context,
                Icons.app_registration_rounded,
                AppLocaleKey.pushNotifications.tr(),
                AppLocaleKey.pushNotificationsDesc.tr(),
                true,
              ),
              _buildAlertToggle(
                context,
                Icons.webhook_rounded,
                AppLocaleKey.webhookAlerts.tr(),
                AppLocaleKey.webhookAlertsDesc.tr(),
                false,
              ),
            ]),
            Gap(32.h),
            _buildAlertSection(context, AppLocaleKey.alertCategories.tr(), [
              _buildAlertToggle(
                context,
                Icons.admin_panel_settings_rounded,
                AppLocaleKey.newBookingRequests.tr(),
                AppLocaleKey.newBookingRequestsDesc.tr(),
                true,
              ),
              _buildAlertToggle(
                context,
                Icons.payments_rounded,
                AppLocaleKey.paymentSuccess.tr(),
                AppLocaleKey.paymentSuccessDesc.tr(),
                true,
              ),
              _buildAlertToggle(
                context,
                Icons.error_outline_rounded,
                AppLocaleKey.criticalSystemErrors.tr(),
                AppLocaleKey.criticalSystemErrorsDesc.tr(),
                true,
              ),
              _buildAlertToggle(
                context,
                Icons.inventory_2_rounded,
                AppLocaleKey.lowStockWarnings.tr(),
                AppLocaleKey.lowStockWarningsDesc.tr(),
                false,
              ),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertsPromo(BuildContext context) {
    return FadeInDown(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.primaryColor(context).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: 0.1)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.notifications_active_rounded, color: AppColor.primaryColor(context), size: 32.sp),
            ),
            Gap(16.h),
            Text(
              AppLocaleKey.intelligenceCenter.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context),
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gap(8.h),
            Text(
              AppLocaleKey.intelligenceCenterDesc.tr(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlertSection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.5),
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(16.h),
        ...items,
      ],
    );
  }

  Widget _buildAlertToggle(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    bool initialValue,
  ) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: baseColor.withValues(alpha: 0.03),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: baseColor.withValues(alpha: 0.05)),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
          leading: Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: baseColor.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: baseColor, size: 22.sp),
          ),
          title: Text(
            title,
            style: TextStyle(color: baseColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(color: baseColor.withValues(alpha: 0.4), fontSize: 11.sp),
          ),
          trailing: Switch(
            value: initialValue,
            onChanged: (val) {},
            activeTrackColor: AppColor.primaryColor(context).withValues(alpha: 0.3),
            activeColor: AppColor.primaryColor(context),
          ),
        ),
      ),
    );
  }
}
