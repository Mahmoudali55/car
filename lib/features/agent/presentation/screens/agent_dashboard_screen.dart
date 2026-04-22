import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_avatar_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_commission_banner_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_kpi_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_lead_tile_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_quick_action_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_tier_badge_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_weekly_chart_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/quick_stat_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_header.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: AgentTheme.navy,
      body: CustomScrollView(
        slivers: [

          // ───────────────── HEADER ─────────────────
          SliverAppBar(
            expandedHeight: 170.h, // 👈 أقل و أنضف
            pinned: true,
            backgroundColor: AgentTheme.navy2,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: SafeArea(
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 16.h),
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
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'مرحباً، محمد',
                                  style: TextStyle(
                                    color: AgentTheme.text1,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 20.sp,
                                  ),
                                ),
                                Text(
                                  'مستشار مبيعات',
                                  style: TextStyle(
                                      color: AgentTheme.text2,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                          const PremiumTierBadge(),
                        ],
                      ),

                      Gap(14.h),

                      /// STATS
                      Row(
                        children: [
                          Expanded(
                            child: QuickStat(
                              icon: Icons.calendar_today,
                              label: 'مواعيد',
                              value: '${todayAppts.length}',
                              color: AgentTheme.blue,
                            ),
                          ),
                          Gap(8.w),
                          Expanded(
                            child: QuickStat(
                              icon: Icons.person_add,
                              label: 'جدد',
                              value:
                                  '${pendingLeads.where((l) => l.status == LeadStatus.newLead).length}',
                              color: AgentTheme.green,
                            ),
                          ),
                          Gap(8.w),
                          const Expanded(
                            child: QuickStat(
                              icon: Icons.trending_up,
                              label: 'الأداء',
                              value: '87%',
                              color: AgentTheme.orange,
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

          // ───────────────── BODY ─────────────────
          SliverPadding(
            padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 30.h),
            sliver: SliverList(
              delegate: SliverChildListDelegate([

                /// Commission
                const PremiumCommissionBanner(),
                Gap(22.h),

                /// KPIs
                const SectionHeader(title: 'المقاييس'),
                Gap(10.h),

                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: kAgentKpis.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 1.2, // 👈 أحسن
                  ),
                  itemBuilder: (_, i) =>
                      PremiumKpiCard(kpi: kAgentKpis[i]),
                ),

                Gap(22.h),

                /// Chart
                const SectionHeader(title: 'الأسبوع'),
                Gap(10.h),
                const PremiumWeeklyChart(
                  data: _weeklyData,
                  days: _weekDays,
                ),

                Gap(22.h),

                /// Actions
                const SectionHeader(title: 'إجراءات'),
                Gap(10.h),

                GridView.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    PremiumQuickAction(
                        icon: Icons.person_add,
                        label: 'عميل',
                        color: AgentTheme.blue),
                    PremiumQuickAction(
                        icon: Icons.event,
                        label: 'موعد',
                        color: AgentTheme.orange),
                    PremiumQuickAction(
                        icon: Icons.note_add,
                        label: 'ملاحظة',
                        color: AgentTheme.green),
                  ],
                ),

                Gap(22.h),

                /// Leads
                SectionHeader(
                  title: 'العملاء',
                  trailing: '${pendingLeads.length}',
                  trailingColor: AgentTheme.blue,
                ),

                Gap(10.h),

                if (pendingLeads.isEmpty)
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.h),
                      child: Text(
                        'لا يوجد عملاء',
                        style: TextStyle(
                            color: AgentTheme.text2,
                            fontSize: 14.sp),
                      ),
                    ),
                  )
                else
                  ...pendingLeads
                      .map((l) => PremiumLeadTile(lead: l)),

              ]),
            ),
          ),
        ],
      ),
    );
  }
}
