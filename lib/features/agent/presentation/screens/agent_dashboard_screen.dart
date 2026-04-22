import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_avatar_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_commission_banner_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_kpi_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_lead_tile_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_quick_action_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_theme_toggle_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_language_toggle_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_weekly_chart_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/quick_stat_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_header_widget.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/features/agent/presentation/screens/agent_add_appointment_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_add_lead_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_add_note_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
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
      AppLocaleKey.fri.tr()
    ];

    final pendingLeads = getAgentLeads()
        .where((l) =>
            l.status == LeadStatus.newLead ||
            l.status == LeadStatus.inProgress)
        .toList();

    final todayAppts = getAgentAppointments()
        .where((a) =>
            a.status == AppointmentStatus.upcoming ||
            a.status == AppointmentStatus.checkedIn)
        .toList();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: CustomScrollView(
        slivers: [
          // ───────────────── HEADER ─────────────────
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            backgroundColor: AppColor.appBarColor(context),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColor.blueColor(context).withOpacity(0.15),
                      AppColor.appBarColor(context),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// TOP
                        Row(
                          children: [
                            const PremiumAvatar(initials: null, localizedInitials: AppLocaleKey.agentUserInitials),
                            Gap(12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocaleKey.agentWelcomeName.tr(namedArgs: {'name': AppLocaleKey.agentUserName.tr()}),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: AppColor.blackTextColor(context),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    AppLocaleKey.agentSalesConsultant.tr(),
                                    style: TextStyle(
                                        color: AppColor.greyColor(context),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600),
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

                        const Spacer(),

                        /// STATS
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
                                value: '${pendingLeads.where((l) => l.status == LeadStatus.newLead).length}',
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

          // ───────────────── BODY ─────────────────
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 30.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                /// Commission
                const PremiumCommissionBanner(),
                Gap(24.h),

                /// KPIs
                SectionHeader(title: AppLocaleKey.agentKeyMetrics.tr()),
                Gap(12.h),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getAgentKpis().length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 1.08,
                  ),
                  itemBuilder: (_, i) => PremiumKpiCard(kpi: getAgentKpis()[i]),
                ),

                Gap(24.h),

                /// Chart
                SectionHeader(title: AppLocaleKey.agentWeeklyActivity.tr()),
                Gap(12.h),
                PremiumWeeklyChart(
                  data: _weeklyData,
                  days: weekDays,
                ),

                Gap(24.h),

                /// Actions
                SectionHeader(title: AppLocaleKey.agentQuickActions.tr()),
                Gap(5.h),

                GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PremiumQuickAction(
                      icon: Icons.person_add_alt_1_rounded,
                      label: AppLocaleKey.agentCustomer.tr(),
                      color: AppColor.blueColor(context),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AgentAddLeadScreen()),
                      ),
                    ),
                    PremiumQuickAction(
                      icon: Icons.event_available_rounded,
                      label: AppLocaleKey.agentAppointment.tr(),
                      color: AppColor.orangeColor(context),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AgentAddAppointmentScreen()),
                      ),
                    ),
                    PremiumQuickAction(
                      icon: Icons.note_add_rounded,
                      label: AppLocaleKey.agentNote.tr(),
                      color: AppColor.greenColor(context),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const AgentAddNoteScreen()),
                      ),
                    ),
                  ],
                ),

                Gap(24.h),

                /// Leads
                SectionHeader(
                  title: AppLocaleKey.agentActiveCustomers.tr(),
                  count: pendingLeads.length,
                  color: AppColor.blueColor(context),
                ),

                Gap(12.h),

                if (pendingLeads.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Text(
                        AppLocaleKey.agentNoCustomersFound.tr(),
                        style: TextStyle(
                            color: AppColor.greyColor(context),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                else
                  ...pendingLeads.map((l) => PremiumLeadTile(lead: l)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
