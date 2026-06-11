import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/custom_gridview_with_dashoard_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_language_toggle_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_theme_toggle_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/quick_stat_widget.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
class AgentDashboardScreen extends StatelessWidget {
  const AgentDashboardScreen({super.key});
  static const _weeklyData = [4, 6, 3, 8, 5, 7, 4];
  @override
  Widget build(BuildContext context) {
    final weekDays = [
      AppLocaleKey.sat.tr(),
      AppLocaleKey.sun.tr(),
      AppLocaleKey.mon.tr(),
      AppLocaleKey.tue.tr(),
      AppLocaleKey.wed.tr(),
      AppLocaleKey.thu.tr(),
      AppLocaleKey.fri.tr(),
    ];
    final pendingLeads = getAgentLeads()
        .where((l) => l.status == LeadStatus.newLead || l.status == LeadStatus.inProgress)
        .toList();
    final todayAppts = getAgentAppointments()
        .where(
          (a) => a.status == AppointmentStatus.upcoming || a.status == AppointmentStatus.checkedIn,
        )
        .toList();
    return Scaffold(
      backgroundColor: AppColor.appBarColor(context),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: AppColor.appBarColor(context),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: AppColor.appBarColor(context),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Gap(12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocaleKey.agentWelcomeName.tr(
                                      namedArgs: {'name': AppLocaleKey.agentUserName.tr()},
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.titleMedium(context).copyWith(
                                      color: AppColor.blackTextColor(context),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18.sp,
                                    ),
                                  ),
                                  Text(
                                    AppLocaleKey.agentSalesConsultant.tr(),
                                    style: AppTextStyle.bodySmall(context).copyWith(
                                      color: AppColor.greyColor(context),

                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconBtn(
                              icon: Icons.logout_rounded,
                              onTap: () {
                                context.read<AuthCubit>().logout();
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  RoutesName.loginScreen,
                                  (route) => false,
                                );
                              },
                            ),
                            Gap(10.w),
                            const PremiumThemeToggle(),
                            Gap(10.w),
                            const PremiumLanguageToggle(),
                          ],
                        ),
                        Gap(70.h),
                        Row(
                          children: [
                            Expanded(
                              child: QuickStat(
                                icon: Icons.calendar_today_rounded,
                                label: AppLocaleKey.agentAppointment.tr(),
                                value: '${todayAppts.length}',
                                color: AppColor.blueColor(context),
                              ),
                            ),
                            Gap(8.w),
                            Expanded(
                              child: QuickStat(
                                icon: Icons.person_add_rounded,
                                label: AppLocaleKey.agentNew.tr(),
                                value:
                                    '${pendingLeads.where((l) => l.status == LeadStatus.newLead).length}',
                                color: AppColor.greenColor(context),
                              ),
                            ),
                            Gap(8.w),
                            Expanded(
                              child: QuickStat(
                                icon: Icons.trending_up_rounded,
                                label: AppLocaleKey.agentPerformance.tr(),
                                value: '87%',
                                color: AppColor.orangeColor(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          CustomGridviewWithDashoardWidget(
            weeklyData: _weeklyData,
            weekDays: weekDays,
            pendingLeads: pendingLeads,
          ),
        ],
      ),
    );
  }
}
