import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ManageCarsScreen extends StatefulWidget {
  const ManageCarsScreen({super.key});

  @override
  State<ManageCarsScreen> createState() => _ManageCarsScreenState();
}

class _ManageCarsScreenState extends State<ManageCarsScreen> {
  String selectedFilter = 'الكل';

  final List<Map<String, String>> dummyCars = [
    {'name': 'Mercedes Benz G63', 'status': 'مؤجرة', 'price': '1200'},
    {'name': 'Bentley Continental', 'status': 'متاحة', 'price': '2500'},
    {'name': 'Ferrari F8 Tributo', 'status': 'في الصيانة', 'price': '3500'},
    {'name': 'Range Rover Vogue', 'status': 'مؤجرة', 'price': '900'},
    {'name': 'Lamborghini Urus', 'status': 'متاحة', 'price': '4000'},
    {'name': 'Porsche 911 Turbo', 'status': 'متاحة', 'price': '2200'},
    {'name': 'Audi RS7 Sportback', 'status': 'في الصيانة', 'price': '1500'},
    {'name': 'Mercedes S-Class', 'status': 'متاحة', 'price': '1800'},
  ];

  @override
  Widget build(BuildContext context) {
    final filteredCars = selectedFilter == 'الكل'
        ? dummyCars
        : dummyCars.where((car) => car['status'] == selectedFilter).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.whiteColor(context)),
              )
            : null,
        title: Text(
          'إدارة الأسطول 🚙',
          style: AppTextStyle.titleMedium(context).copyWith(
            color: AppColor.whiteColor(context),
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
                key: ValueKey('${selectedFilter}_$index'), // Reset animation on filter change
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
    final filters = ['الكل', 'متاحة', 'في الصيانة', 'مؤجرة'];
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

  Widget _buildFilterChip(String label) {
    final isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        margin: EdgeInsets.only(left: 12.w),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primaryColor(context)
              : AppColor.whiteColor(context).withOpacity(0.05),
          borderRadius: BorderRadius.circular(16.r),
          border: isSelected
              ? null
              : Border.all(color: AppColor.whiteColor(context).withOpacity(0.1)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: isSelected
                ? AppColor.whiteColor(context)
                : AppColor.whiteColor(context).withOpacity(0.5),
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildCarInventoryCard(Map<String, String> car) {
    final status = car['status']!;
    final statusColor = status == 'متاحة'
        ? Colors.greenAccent
        : (status == 'مؤجرة' ? Colors.orangeAccent : Colors.redAccent);

    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor(context).withOpacity(0.03),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColor.whiteColor(context).withOpacity(0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28.r),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 140.h,
                  width: double.infinity,
                  decoration: BoxDecoration(color: AppColor.whiteColor(context).withOpacity(0.05)),
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?q=80&w=500',
                    fit: BoxFit.cover,
                    placeholder: (context, url) =>
                        Container(color: AppColor.whiteColor(context).withOpacity(0.05)),
                    errorWidget: (context, url, error) => Container(
                      color: AppColor.whiteColor(context).withOpacity(0.05),
                      child: Icon(
                        Icons.error_outline,
                        color: AppColor.whiteColor(context).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12.h,
                  right: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      '2024',
                      style: TextStyle(
                        color: AppColor.whiteColor(context),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 12.h,
                  left: 12.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: statusColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car['name']!,
                        style: TextStyle(
                          color: AppColor.whiteColor(context),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        'السعر اليومي: ${car['price']} د.إ',
                        style: TextStyle(
                          color: AppColor.whiteColor(context).withOpacity(0.4),
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      _buildActionCircle(Icons.edit_note_rounded, Colors.blueAccent),
                      Gap(10.w),
                      _buildActionCircle(Icons.delete_sweep_rounded, Colors.redAccent),
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

  Widget _buildActionCircle(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
      child: Icon(icon, color: color, size: 20.sp),
    );
  }
}
