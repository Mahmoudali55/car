import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppColor.blackTextColor(context),
                ),
              )
            : null,
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
                child: _buildCarInventoryCard(filteredCars[index]),
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
      height: 50.h,
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
              : AppColor.blackTextColor(context).withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? null
              : Border.all(color: AppColor.blackTextColor(context).withOpacity(0.1)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColor.whiteColor(context)
                : AppColor.blackTextColor(context).withOpacity(0.5),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildCarInventoryCard(Map<String, String> car) {
    final statusKey = car['status']!;
    final statusColor = statusKey == AppLocaleKey.adminCarStatusPublished
        ? Colors.greenAccent
        : (statusKey == AppLocaleKey.adminCarStatusPending ? Colors.orangeAccent : Colors.redAccent);

    return Container(
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withOpacity(0.02),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32.r),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 160.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.blackTextColor(context).withOpacity(0.05),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: 'https://images.unsplash.com/photo-1544636331-e26879cd4d9b?q=80&w=500',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppColor.blackTextColor(context).withOpacity(0.05)),
                  ),
                ),
                Positioned(
                  top: 16.h,
                  right: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: Text(
                      car['year']!,
                      style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 16.h,
                  left: 16.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(color: statusColor.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, 4))
                      ],
                    ),
                    child: Text(
                      statusKey.tr(),
                      style: const TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              car['name']!,
                              style: TextStyle(
                                color: AppColor.blackTextColor(context),
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Gap(4.h),
                            Row(
                              children: [
                                Icon(Icons.speed_rounded,
                                    size: 14.sp, color: AppColor.blackTextColor(context).withOpacity(0.4)),
                                Gap(4.w),
                                Text(
                                  car['mileage']!,
                                  style: TextStyle(
                                      color: AppColor.blackTextColor(context).withOpacity(0.4), fontSize: 11.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            car['price']!,
                            style: TextStyle(
                              color: AppColor.primaryColor(context),
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Text(
                            AppLocaleKey.aed.tr(),
                            style: TextStyle(
                              color: AppColor.blackTextColor(context).withOpacity(0.4),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(20.h),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInventoryAction(
                          Icons.edit_note_rounded,
                          AppLocaleKey.edit.tr(),
                          Colors.blueAccent,
                        ),
                      ),
                      Gap(12.w),
                      Expanded(
                        child: _buildInventoryAction(
                          Icons.delete_sweep_rounded,
                          AppLocaleKey.delete.tr(),
                          Colors.redAccent,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInventoryAction(IconData icon, String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 18.sp),
          Gap(8.w),
          Text(
            label,
            style: TextStyle(color: color, fontSize: 12.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
