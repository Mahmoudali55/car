import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ManageCategoriesScreen extends StatelessWidget {
  const ManageCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(context, title: Text(AppLocaleKey.categories.tr())),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColor.primaryColor(context),
        icon: const Icon(Icons.add_rounded, color: Colors.white),
        label: Text(
          AppLocaleKey.addCategory.tr(),
          style: TextStyle(color: Colors.white, fontSize: 13.sp, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryStat(context),
            Gap(32.h),
            _buildCategorySection(context, "Body Types", [
              _buildCategoryCard(context, "SUV", 42, Icons.directions_car_filled_rounded),
              _buildCategoryCard(context, "Sedan", 28, Icons.directions_car_rounded),
              _buildCategoryCard(context, "Sports", 15, Icons.speed_rounded),
              _buildCategoryCard(context, "Electric", 12, Icons.electric_car_rounded),
            ]),
            Gap(32.h),
            _buildCategorySection(context, "Quick Actions", [
              _buildCategoryAction(context, "Reorder Categories", Icons.reorder_rounded, Colors.blueAccent),
              _buildCategoryAction(context, "Merge Categories", Icons.merge_type_rounded, Colors.orangeAccent),
              _buildCategoryAction(context, "Export Categories", Icons.file_download_rounded, Colors.greenAccent),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryStat(BuildContext context) {
    return FadeInDown(
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: AppColor.blackTextColor(context).withOpacity(0.03),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.05)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocaleKey.totalCategories.tr(),
                  style: TextStyle(
                    color: AppColor.blackTextColor(context).withOpacity(0.5),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "24 ACTIVE",
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.analytics_rounded, color: AppColor.primaryColor(context), size: 24.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context, String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeInRight(
          child: Text(
            title,
            style: TextStyle(
              color: AppColor.blackTextColor(context).withOpacity(0.5),
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Gap(16.h),
        ...items,
      ],
    );
  }

  Widget _buildCategoryCard(BuildContext context, String name, int count, IconData icon) {
    final baseColor = AppColor.blackTextColor(context);
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: baseColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: baseColor.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(color: baseColor.withOpacity(0.05), shape: BoxShape.circle),
              child: Icon(icon, color: baseColor, size: 20.sp),
            ),
            Gap(16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(color: baseColor, fontSize: 14.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "$count Listings",
                    style: TextStyle(color: baseColor.withOpacity(0.4), fontSize: 11.sp),
                  ),
                ],
              ),
            ),
            IconButton(onPressed: () {}, icon: Icon(Icons.edit_rounded, color: baseColor.withOpacity(0.3), size: 18.sp)),
            IconButton(onPressed: () {}, icon: Icon(Icons.delete_outline_rounded, color: Colors.redAccent.withOpacity(0.5), size: 18.sp)),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryAction(BuildContext context, String label, IconData icon, Color color) {
    return FadeInUp(
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: color.withOpacity(0.1)),
        ),
        child: ListTile(
          onTap: () {},
          leading: Icon(icon, color: color, size: 22.sp),
          title: Text(
            label,
            style: TextStyle(color: AppColor.blackTextColor(context), fontSize: 13.sp, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.chevron_left_rounded, color: color.withOpacity(0.4)),
        ),
      ),
    );
  }
}
