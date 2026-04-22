import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:car/features/agent/presentation/screens/agent_appointments_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_dashboard_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_inventory_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_leads_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/nav_meta_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgentShell extends StatefulWidget {
  const AgentShell({super.key});

  @override
  State<AgentShell> createState() => _AgentShellState();
}

class _AgentShellState extends State<AgentShell> {
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final screens = [
      AgentDashboardScreen(),
      AgentLeadsScreen(),
      AgentInventoryScreen(),
      AgentAppointmentsScreen(),
    ];

    final navItems = [
      NavMeta(icon: Icons.dashboard_rounded, label: AppLocaleKey.agentNavHome.tr()),
      NavMeta(icon: Icons.people_rounded, label: AppLocaleKey.agentNavCustomers.tr()),
      NavMeta(icon: Icons.directions_car_rounded, label: AppLocaleKey.agentNavInventory.tr()),
      NavMeta(icon: Icons.calendar_month_rounded, label: AppLocaleKey.agentNavAppointments.tr()),
    ];
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        body: IndexedStack(index: _currentIndex, children: screens),
        bottomNavigationBar: BottomNav(
          currentIndex: _currentIndex,
          items: navItems,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}

