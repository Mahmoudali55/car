import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/agent/data/model/agent_models.dart';
import 'package:car/features/agent/presentation/cubit/agent_cubit.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:car/features/agent/presentation/screens/agent_add_appointment_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_add_lead_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_add_note_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_offers_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_kpi_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_lead_tile_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_quick_action_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/premium_weekly_chart_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/section_header_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomGridviewWithDashoardWidget extends StatelessWidget {
  const CustomGridviewWithDashoardWidget({
    super.key,
    required List<int> weeklyData,
    required this.weekDays,
    required this.pendingLeads,
  }) : _weeklyData = weeklyData;

  final List<int> _weeklyData;
  final List<String> weekDays;
  final List<AgentLead> pendingLeads;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentCubit, AgentState>(
      builder: (context, state) {
        final offers = state.offersStatus.data ?? [];
        final offersCount = offers.length;
        final kpis = getAgentKpis(
          inquiries: 14,
          appointments: 3,
          closedDeals: 7,
          sales: offersCount.toDouble(),
        );
        return SliverPadding(
          padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 30.h),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // const PremiumCommissionBanner(),
              Gap(24.h),
              SectionHeader(title: AppLocaleKey.agentKeyMetrics.tr()),
              Gap(12.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: kpis.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12.h,
                  crossAxisSpacing: 12.w,
                  childAspectRatio: 1.08,
                ),
                itemBuilder: (_, i) {
                  final kpiCard = PremiumKpiCard(kpi: kpis[i]);
                  if (i == 3) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AgentOffersScreen(),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(24.r),
                      child: kpiCard,
                    );
                  }
                  return kpiCard;
                },
              ),
              Gap(24.h),
              SectionHeader(title: AppLocaleKey.agentWeeklyActivity.tr()),
              Gap(12.h),
              PremiumWeeklyChart(data: _weeklyData, days: weekDays),
              Gap(24.h),
              SectionHeader(title: AppLocaleKey.agentQuickActions.tr()),
              Gap(12.h),
              GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 12.h,
                crossAxisSpacing: 12.w,
                padding: EdgeInsets.zero,
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
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: AppColor.greyColor(context), fontWeight: FontWeight.w500),
                    ),
                  ),
                )
              else
                ...pendingLeads.map((l) => PremiumLeadTile(lead: l)),
            ]),
          ),
        );
      },
    );
  }
}
