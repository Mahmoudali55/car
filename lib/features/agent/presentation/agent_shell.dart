import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/presentation/screens/agent_appointments_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_dashboard_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_inventory_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_leads_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/nav_meta_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentShell extends StatefulWidget {
  const AgentShell({super.key});

  @override
  State<AgentShell> createState() => _AgentShellState();
}

class _AgentShellState extends State<AgentShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    AgentDashboardScreen(),
    AgentLeadsScreen(),
    AgentInventoryScreen(),
    AgentAppointmentsScreen(),
  ];

  final List<NavMeta> _navItems = const [
    NavMeta(icon: Icons.dashboard_rounded,       label: 'الرئيسية'),
    NavMeta(icon: Icons.people_rounded,           label: 'العملاء'),
    NavMeta(icon: Icons.directions_car_rounded,   label: 'المخزون'),
    NavMeta(icon: Icons.calendar_month_rounded,   label: 'المواعيد'),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: BottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}

