import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/admin/presentation/screen/widgets/alert_toggle_widget.dart';
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
              AlertToggleWidget(
                icon: Icons.mark_email_unread_rounded,
                title: AppLocaleKey.emailNotifications.tr(),
                subtitle: AppLocaleKey.emailNotificationsDesc.tr(),
                initialValue: true,
              ),
              AlertToggleWidget(
                icon: Icons.app_registration_rounded,
                title: AppLocaleKey.pushNotifications.tr(),
                subtitle: AppLocaleKey.pushNotificationsDesc.tr(),
                initialValue: true,
              ),
              AlertToggleWidget(
                icon: Icons.webhook_rounded,
                title: AppLocaleKey.webhookAlerts.tr(),
                subtitle: AppLocaleKey.webhookAlertsDesc.tr(),
                initialValue: false,
              ),
            ]),
            Gap(32.h),
            _buildAlertSection(context, AppLocaleKey.alertCategories.tr(), [
              AlertToggleWidget(
                icon: Icons.webhook_rounded,
                title: AppLocaleKey.webhookAlerts.tr(),
                subtitle: AppLocaleKey.webhookAlertsDesc.tr(),
                initialValue: false,
              ),
            ]),
            Gap(32.h),
            _buildAlertSection(context, AppLocaleKey.alertCategories.tr(), [
              AlertToggleWidget(
                icon: Icons.admin_panel_settings_rounded,
                title: AppLocaleKey.newBookingRequests.tr(),
                subtitle: AppLocaleKey.newBookingRequestsDesc.tr(),
                initialValue: true,
              ),
              AlertToggleWidget(
                icon: Icons.payments_rounded,
                title: AppLocaleKey.paymentSuccess.tr(),
                subtitle: AppLocaleKey.paymentSuccessDesc.tr(),
                initialValue: true,
              ),
              AlertToggleWidget(
                icon: Icons.error_outline_rounded,
                title: AppLocaleKey.criticalSystemErrors.tr(),
                subtitle: AppLocaleKey.criticalSystemErrorsDesc.tr(),
                initialValue: true,
              ),
              AlertToggleWidget(
                icon: Icons.inventory_2_rounded,
                title: AppLocaleKey.lowStockWarnings.tr(),
                subtitle: AppLocaleKey.lowStockWarningsDesc.tr(),
                initialValue: false,
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
          color: AppColor.primaryColor(context).withValues(alpha: (0.05)),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColor.primaryColor(context).withValues(alpha: (0.1))),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: (0.1)),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_active_rounded,
                color: AppColor.primaryColor(context),
                size: 32.sp,
              ),
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
                color: AppColor.blackTextColor(context).withValues(alpha: (0.5)),
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
              color: AppColor.blackTextColor(context).withValues(alpha: (0.5)),
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
}
