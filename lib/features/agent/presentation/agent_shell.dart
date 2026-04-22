import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/agent_appointments_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_dashboard_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_inventory_screen.dart';
import 'package:car/features/agent/presentation/screens/agent_leads_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  final List<_NavMeta> _navItems = const [
    _NavMeta(icon: Icons.dashboard_rounded,       label: 'الرئيسية'),
    _NavMeta(icon: Icons.people_rounded,           label: 'العملاء'),
    _NavMeta(icon: Icons.directions_car_rounded,   label: 'المخزون'),
    _NavMeta(icon: Icons.calendar_month_rounded,   label: 'المواعيد'),
  ];

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AgentTheme.navy,
        body: IndexedStack(index: _currentIndex, children: _screens),
        bottomNavigationBar: _BottomNav(
          currentIndex: _currentIndex,
          items: _navItems,
          onTap: (i) => setState(() => _currentIndex = i),
        ),
      ),
    );
  }
}

class _NavMeta {
  final IconData icon;
  final String label;
  const _NavMeta({required this.icon, required this.label});
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final List<_NavMeta> items;
  final ValueChanged<int> onTap;

  const _BottomNav({
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AgentTheme.navy2,
        border: Border(
          top: BorderSide(color: AgentTheme.border, width: 1),
        ),
        boxShadow: [
          BoxShadow(
            color: AgentTheme.blue.withOpacity(0.15),
            blurRadius: 24,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (i) {
              final selected = currentIndex == i;
              return GestureDetector(
                onTap: () => onTap(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: selected
                        ? AgentTheme.blue.withOpacity(0.12)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        items[i].icon,
                        size: 22.sp,
                        color: selected ? AgentTheme.gold : AgentTheme.text3,
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        items[i].label,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: selected ? FontWeight.w900 : FontWeight.normal,
                          color: selected ? AgentTheme.gold : AgentTheme.text3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
