import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/agent_car_details_screen.dart';
import 'package:car/features/agent/presentation/screens/widget/car_list_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
class AgentInventoryScreen extends StatefulWidget {
  const AgentInventoryScreen({super.key});
  @override
  State<AgentInventoryScreen> createState() => _AgentInventoryScreenState();
}
class _AgentInventoryScreenState extends State<AgentInventoryScreen> {
  List<AgentCar> _getByFilter(CarAvailability? filter) {
    if (filter == null) return getAgentCars();
    return getAgentCars().where((c) => c.availability == filter).toList();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColor.scaffoldColor(context),
        body: NestedScrollView(
          headerSliverBuilder: (_, _) => [
            SliverAppBar(
              pinned: true,
              backgroundColor: AppColor.appBarColor(context),
              expandedHeight: 80.h, 
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 0),
                    child: Text(
                      AppLocaleKey.agentInventory.tr(),
                      style: TextStyle(
                        color: AppColor.blackTextColor(context),
                        fontWeight: FontWeight.w900,
                        fontSize: 24.sp,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
              ),
              bottom: TabBar(
                indicatorColor: AppColor.blueColor(context),
                indicatorWeight: 3.5.h,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: AppColor.blackTextColor(context),
                unselectedLabelColor: AppColor.hintColor(context),
                labelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w900),
                unselectedLabelStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                indicatorPadding: EdgeInsets.symmetric(horizontal: 4.w),
                tabs: [
                  Tab(text: AppLocaleKey.agentAll.tr()),
                  Tab(text: AppLocaleKey.agentAvailable.tr()),
                  Tab(text: AppLocaleKey.agentReserved.tr()),
                  Tab(text: AppLocaleKey.agentSold.tr()),
                ],
              ),
            ),
          ],
          body: TabBarView(
            children: [
              _buildList(_getByFilter(null)),
              _buildList(_getByFilter(CarAvailability.available)),
              _buildList(_getByFilter(CarAvailability.reserved)),
              _buildList(_getByFilter(CarAvailability.sold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildList(List<AgentCar> list) {
    if (list.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.directions_car_filled_outlined, size: 48.sp, color: AppColor.hintColor(context)),
            Gap(12.h),
            Text(
              AppLocaleKey.agentNoDataAvailable.tr(),
              style: TextStyle(color: AppColor.hintColor(context), fontSize: 14.sp, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 40.h),
      itemCount: list.length,
      itemBuilder: (_, i) => CarListCard(
        car: list[i],
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AgentCarDetailsScreen(car: list[i]),
          ),
        ),
      ),
    );
  }
}
