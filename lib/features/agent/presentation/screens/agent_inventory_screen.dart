import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/car_grid_card_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/car_list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgentInventoryScreen extends StatefulWidget {
  const AgentInventoryScreen({super.key});

  @override
  State<AgentInventoryScreen> createState() => _AgentInventoryScreenState();
}

class _AgentInventoryScreenState extends State<AgentInventoryScreen> {
  bool _isGrid = true;

  List<AgentCar> _getByFilter(CarAvailability? filter) {
    if (filter == null) return kAgentCars;
    return kAgentCars.where((c) => c.availability == filter).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AgentTheme.navy,
        body: NestedScrollView(
          headerSliverBuilder: (_, _) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: AgentTheme.navy2,
              expandedHeight: 110.h,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0),
                    child: Row(
                      children: [
                        Text('المخزون',
                            style: TextStyle(
                                color: AgentTheme.text1,
                                fontWeight: FontWeight.w900,
                                fontSize: 22.sp)),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => setState(() => _isGrid = !_isGrid),
                          child: Container(
                            width: 38.w,
                            height: 38.w,
                            decoration: BoxDecoration(
                              color: AgentTheme.blue.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(11.r),
                              border: Border.all(color: AgentTheme.blue.withOpacity(0.25)),
                            ),
                            child: Icon(
                              _isGrid ? Icons.view_list_rounded : Icons.grid_view_rounded,
                              color: AgentTheme.blue,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 🔥 هنا التاب بار
              bottom: const TabBar(
                indicatorColor: AgentTheme.blue,
                labelColor: Colors.white,
                unselectedLabelColor: AgentTheme.text3,
                tabs: [
                  Tab(text: 'الكل'),
                  Tab(text: 'متاحة'),
                  Tab(text: 'محجوزة'),
                  Tab(text: 'مباعة'),
                ],
              ),
            ),
          ],

          // 🔥 محتوى التابات
          body: TabBarView(
            children: [
              _buildContent(_getByFilter(null)),
              _buildContent(_getByFilter(CarAvailability.available)),
              _buildContent(_getByFilter(CarAvailability.reserved)),
              _buildContent(_getByFilter(CarAvailability.sold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(List<AgentCar> list) {
    return _isGrid ? _buildGrid(list) : _buildList(list);
  }

  Widget _buildGrid(List<AgentCar> list) {
    return GridView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
      itemCount: list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.56,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemBuilder: (_, i) => CarGridCard(car: list[i]),
    );
  }

  Widget _buildList(List<AgentCar> list) {
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 40.h),
      itemCount: list.length,
      itemBuilder: (_, i) => CarListCard(car: list[i]),
    );
  }
}
