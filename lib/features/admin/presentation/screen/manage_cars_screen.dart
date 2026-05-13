import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/presentation/screen/widgets/car_inventory_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ManageCarsScreen extends StatefulWidget {
  const ManageCarsScreen({super.key});

  @override
  State<ManageCarsScreen> createState() => _ManageCarsScreenState();
}

class _ManageCarsScreenState extends State<ManageCarsScreen> {
  String selectedFilterKey = AppLocaleKey.all;

  final List<Map<String, String>> dummyCars = [
    {
      'name': 'Mercedes Benz G63',
      'status': AppLocaleKey.adminCarStatusPublished,
      'price': '1,200',
      'year': '2024',
      'mileage': '5,000 km',
    },
    {
      'name': 'Bentley Continental',
      'status': AppLocaleKey.adminCarStatusPublished,
      'price': '2,500',
      'year': '2023',
      'mileage': '1,200 km',
    },
    {
      'name': 'Ferrari F8 Tributo',
      'status': AppLocaleKey.adminCarStatusPending,
      'price': '3,500',
      'year': '2024',
      'mileage': '0 km',
    },
    {
      'name': 'Range Rover Vogue',
      'status': AppLocaleKey.adminCarStatusPublished,
      'price': '900',
      'year': '2022',
      'mileage': '24,000 km',
    },
    {
      'name': 'Lamborghini Urus',
      'status': AppLocaleKey.adminCarStatusDeleted,
      'price': '4,000',
      'year': '2023',
      'mileage': '8,500 km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCars = selectedFilterKey == AppLocaleKey.all
        ? dummyCars
        : dummyCars.where((car) => car['status'] == selectedFilterKey).toList();

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        appBarColor: AppColor.scaffoldColor(context),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: SizedBox.shrink(),
        title: Text(
          AppLocaleKey.fleetManagement.tr(),
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.blackTextColor(context),
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, RoutesName.addCar),
            icon: Icon(
              Icons.add_circle_rounded,
              color: AppColor.primaryColor(context),
              size: 28.sp,
            ),
          ),
          Gap(10.w),
        ],
      ),
      body: Column(
        children: [
          _buildStatusFilters(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: filteredCars.length,
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => Gap(20.h),
              itemBuilder: (context, index) => FadeInUp(
                key: ValueKey('${selectedFilterKey}_$index'), // Reset animation on filter change
                delay: Duration(milliseconds: index * 40),
                child: CarInventoryCardWidget(car: filteredCars[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilters() {
    final filters = [
      AppLocaleKey.all,
      AppLocaleKey.adminCarStatusPublished,
      AppLocaleKey.adminCarStatusPending,
      AppLocaleKey.adminCarStatusDeleted,
    ];
    return Container(
      height: 45.h,
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        itemBuilder: (context, index) => _buildFilterChip(filters[index]),
      ),
    );
  }

  Widget _buildFilterChip(String labelKey) {
    final isSelected = selectedFilterKey == labelKey;
    final label = labelKey.tr();

    return GestureDetector(
      onTap: () => setState(() => selectedFilterKey = labelKey),
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context)
              : AppColor.blackTextColor(context).withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? null
              : Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.1)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColor.whiteColor(context)
                : AppColor.blackTextColor(context).withValues(alpha: 0.5),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }
}
