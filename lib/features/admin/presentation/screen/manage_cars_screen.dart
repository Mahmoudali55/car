import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/car_filter_chips.dart';
import 'package:car/features/admin/presentation/screen/widgets/car_inventory_card.dart';
import 'package:car/features/admin/presentation/screen/widgets/fleet_stats_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'widgets/empty_state_widget.dart';

class ManageCarsScreen extends StatefulWidget {
  const ManageCarsScreen({super.key});

  @override
  State<ManageCarsScreen> createState() => _ManageCarsScreenState();
}

class _ManageCarsScreenState extends State<ManageCarsScreen> {
  String _selectedFilter = 'all';

  final List<Map<String, String>> _cars = [
    {
      'name': 'Mercedes Benz G63',
      'status': 'published',
      'price': '1,200,000',
      'year': '2024',
      'mileage': '5,000 كم',
      'image': 'assets/images/gclass.png',
    },
    {
      'name': 'Bentley Continental',
      'status': 'published',
      'price': '2,500,000',
      'year': '2023',
      'mileage': '1,200 كم',
      'image': 'assets/images/ferrari.png',
    },
    {
      'name': 'Ferrari F8 Tributo',
      'status': 'pending',
      'price': '3,500,000',
      'year': '2024',
      'mileage': '0 كم',
      'image': 'assets/images/ferrari.png',
    },
    {
      'name': 'Range Rover Vogue',
      'status': 'published',
      'price': '900,000',
      'year': '2022',
      'mileage': '24,000 كم',
      'image': 'assets/images/coupon_pattern.png',
    },
    {
      'name': 'Lamborghini Urus',
      'status': 'deleted',
      'price': '4,000,000',
      'year': '2023',
      'mileage': '8,500 كم',
      'image': 'assets/images/yaris.png',
    },
  ];

  List<Map<String, String>> get _filtered => _selectedFilter == 'all'
      ? _cars
      : _cars.where((c) => c['status'] == _selectedFilter).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        appBarColor: AppColor.scaffoldColor(context),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: const SizedBox.shrink(),
        centerTitle: false,
        title: Text(
          AppLocaleKey.fleetManagement.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: 20.sp),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, RoutesName.addCar),
            icon: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(Icons.add_rounded, color: AppColor.primaryColor(context), size: 20.sp),
            ),
          ),
          Gap(10.w),
        ],
      ),
      body: Column(
        children: [
          FleetStatsRow(cars: _cars),
          SizedBox(height: 14.h),
          CarFilterChips(
            selectedFilter: _selectedFilter,
            onFilterChanged: (f) => setState(() => _selectedFilter = f),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: _filtered.isEmpty
                  ? EmptyState(key: const ValueKey('empty'))
                  : ListView.separated(
                      key: ValueKey(_selectedFilter),
                      padding: EdgeInsets.all(16.w),
                      physics: const BouncingScrollPhysics(),
                      itemCount: _filtered.length,
                      separatorBuilder: (_, __) => Gap(10.h),
                      itemBuilder: (context, i) => FadeInUp(
                        delay: Duration(milliseconds: i * 40),
                        duration: const Duration(milliseconds: 300),
                        child: CarInventoryCard(
                          car: _filtered[i],
                          onEdit: () {},
                          onWhatsApp: () {},
                          onDelete: () {},
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
