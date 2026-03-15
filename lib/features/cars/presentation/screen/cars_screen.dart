import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  int _selectedFilterIndex = 0;
  final List<String> _filters = ['الكل', 'فاخرة', 'رياضية', 'SUV', 'سيدان'];

  // Dummy premium data
  final List<Map<String, dynamic>> _cars = [
    {
      'brand': 'Mercedes-Benz',
      'name': 'G-Class G63 AMG',
      'price': '850,000 درهم',
      'year': '2023',
      'mileage': '12,000 كم',
      'image':
          'assets/images/cars/mercedes-benz.png', // Fallback to a brand logo if real image is missing
      'isFavorite': false,
    },
    {
      'brand': 'Porsche',
      'name': '911 Turbo S',
      'price': '920,000 درهم',
      'year': '2024',
      'mileage': '5,000 كم',
      'image': 'assets/images/cars/porsche.png',
      'isFavorite': true,
    },
    {
      'brand': 'BMW',
      'name': 'M8 Competition',
      'price': '650,000 درهم',
      'year': '2022',
      'mileage': '24,000 كم',
      'image': 'assets/images/cars/bmw.png',
      'isFavorite': false,
    },
    {
      'brand': 'Audi',
      'name': 'RS Q8',
      'price': '580,000 درهم',
      'year': '2023',
      'mileage': '18,000 كم',
      'image': 'assets/images/cars/audi.png',
      'isFavorite': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 12.h),
              child: CustomFormField(
                radius: 16.r,
                onChanged: (val) {},
                prefixIcon: const Icon(Icons.search),
                hintText: 'ابحث عن سيارة أحلامك...',
              ),
            ),

            // Filter Chips
            SizedBox(
              height: 40.h,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemCount: _filters.length,
                separatorBuilder: (context, index) => Gap(12.w),
                itemBuilder: (context, index) {
                  final isSelected = _selectedFilterIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilterIndex = index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColor.primaryColor(context)
                            : AppColor.secondAppColor(context),
                        borderRadius: BorderRadius.circular(20.r),
                        border: isSelected
                            ? null
                            : Border.all(color: AppColor.borderColor(context).withOpacity(0.2)),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        _filters[index],
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: isSelected ? Colors.white : AppColor.darkTextColor(context),
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Gap(16.h),

            // Cars Listing Grid
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.65,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.h,
                ),
                itemCount: _cars.length,
                itemBuilder: (context, index) {
                  final car = _cars[index];
                  return _buildPremiumCarCard(car);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPremiumCarCard(Map<String, dynamic> car) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.whiteColor(context),
        borderRadius: BorderRadius.circular(20.r),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image Section
              Expanded(
                flex: 4,
                child: Container(
                  width: double.infinity,
                  color: Colors.white.withOpacity(0.02),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Car Image (Placeholder uses brand icon for now)
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Image.asset(car['image'], fit: BoxFit.contain),
                      ),
                    ],
                  ),
                ),
              ),

              // Details Section
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car['brand'],
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(4.h),
                          Text(
                            car['name'],
                            style: AppTextStyle.titleSmall(context).copyWith(fontSize: 14.sp),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),

                      // Specs Row (Year, Mileage)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildSpecIcon(Icons.calendar_today_outlined, car['year']),
                          _buildSpecIcon(Icons.speed_outlined, car['mileage']),
                        ],
                      ),

                      // Price
                      Text(
                        car['price'],
                        style: AppTextStyle.titleMedium(context).copyWith(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // Favorite Button
          Positioned(
            top: 8.h,
            left: 8.w, // Assuming RTL, left is visually correct. Change to right if needed.
            child: CircleAvatar(
              radius: 16.r,
              backgroundColor: AppColor.secondAppColor(context).withOpacity(0.7),
              child: Icon(
                car['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                color: car['isFavorite'] ? Colors.redAccent : Colors.white,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecIcon(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14.sp, color: AppColor.greyColor(context)),
        Gap(4.w),
        Text(label, style: AppTextStyle.bodySmall(context).copyWith(fontSize: 10.sp)),
      ],
    );
  }
}
