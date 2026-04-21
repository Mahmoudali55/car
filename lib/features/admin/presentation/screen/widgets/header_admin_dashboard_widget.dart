import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/header_action_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HeaderAdminDashboardWidget extends StatelessWidget {
  const HeaderAdminDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocaleKey.centralDashboard.tr(),
              style: AppTextStyle.titleMedium(context).copyWith(
                color: AppColor.blackTextColor(context),
                fontWeight: FontWeight.w900,
                fontSize: 22.sp,
              ),
            ),
            Gap(4.h),
            Text(
              AppLocaleKey.performanceSummary.tr(),
              style: TextStyle(
                color: AppColor.blackTextColor(context).withOpacity(0.4),
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        Row(
          children: [
            HeaderActionWidget(
              icon: Icons.notifications_none_rounded,
              color: AppColor.primaryColor(context),
              onTap: () => Navigator.pushNamed(context, RoutesName.adminNotifications),
            ),
            Gap(12.w),
            HeaderActionWidget(
              icon: Icons.logout_rounded,
              color: Colors.redAccent,
              onTap: () {
                HiveMethods.deleteToken();
                HiveMethods.updateRole('user');
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RoutesName.loginScreen,
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
