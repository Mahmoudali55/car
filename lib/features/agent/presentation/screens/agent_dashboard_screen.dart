import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_avatar_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_commission_banner_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_kpi_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_lead_tile_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_quick_action_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_theme_toggle_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_weekly_chart_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/quick_stat_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_header_widget.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:car/features/auth/presentation/view/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';


class AgentDashboardScreen extends StatelessWidget {
  const AgentDashboardScreen({super.key});

  static const _weeklyData = [4, 6, 3, 8, 5, 7, 4];
  static const _weekDays = ['س', 'ح', 'إ', 'ث', 'أ', 'خ', 'ج'];

  @override
  Widget build(BuildContext context) {
    final pendingLeads = kAgentLeads
        .where((l) =>
            l.status == LeadStatus.newLead ||
            l.status == LeadStatus.inProgress)
        .toList();

    final todayAppts = kAgentAppointments
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
            expandedHeight: 180.h,
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
                            const PremiumAvatar(initials: 'م.ع'),
                            Gap(12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'مرحباً، محمد',
                                    style: TextStyle(
                                      color: AppColor.blackTextColor(context),
                                      fontWeight: FontWeight.w900,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  Text(
                                    'مستشار مبيعات',
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
                            
                          ],
                        ),

                        const Spacer(),

                        /// STATS
                        Row(
                          children: [
                            Expanded(
                              child: QuickStat(
                                icon: Icons.calendar_today_rounded,
                                label: 'مواعيد',
                                value: '${todayAppts.length}',
                                color: AppColor.blueColor(context),
                              ),
                            ),
                            Gap(8.w),
                            Expanded(
                              child: QuickStat(
                                icon: Icons.person_add_rounded,
                                label: 'جدد',
                                value: '${pendingLeads.where((l) => l.status == LeadStatus.newLead).length}',
                                color: AppColor.greenColor(context),
                              ),
                            ),
                            Gap(8.w),
                            Expanded(
                              child: QuickStat(
                                icon: Icons.trending_up_rounded,
                                label: 'الأداء',
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
                const SectionHeader(title: 'المقاييس الأساسية'),
                Gap(12.h),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: kAgentKpis.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12.h,
                    crossAxisSpacing: 12.w,
                    childAspectRatio: 1.15,
                  ),
                  itemBuilder: (_, i) => PremiumKpiCard(kpi: kAgentKpis[i]),
                ),

                Gap(24.h),

                /// Chart
                const SectionHeader(title: 'النشاط الأسبوعي'),
                Gap(12.h),
                const PremiumWeeklyChart(
                  data: _weeklyData,
                  days: _weekDays,
                ),

                Gap(24.h),

                /// Actions
                const SectionHeader(title: 'إجراءات سريعة'),
                Gap(12.h),

                GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    PremiumQuickAction(
                        icon: Icons.person_add_alt_1_rounded,
                        label: 'عميل',
                        color: AppColor.blueColor(context)),
                    PremiumQuickAction(
                        icon: Icons.event_available_rounded,
                        label: 'موعد',
                        color: AppColor.orangeColor(context)),
                    PremiumQuickAction(
                        icon: Icons.note_add_rounded,
                        label: 'ملاحظة',
                        color: AppColor.greenColor(context)),
                  ],
                ),

                Gap(24.h),

                /// Leads
                SectionHeader(
                  title: 'العملاء النشطون',
                  count: pendingLeads.length,
                  color: AppColor.blueColor(context),
                ),

                Gap(12.h),

                if (pendingLeads.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Text(
                        'لا يوجد عملاء في القائمة حالياً',
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
