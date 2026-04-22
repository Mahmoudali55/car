import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/icon_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class AgentCarDetailsScreen extends StatelessWidget {
  final AgentCar car;
  const AgentCarDetailsScreen({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    final availabilityColor = car.getAvailabilityColor(context);

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      body: Stack(
        children: [
          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // ── Header ──────────────────────────────────────────────────
              SliverAppBar(
                expandedHeight: 320.h,
                pinned: true,
                elevation: 0,
                backgroundColor: AppColor.appBarColor(context),
                leading: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: IconBtn(
                    icon: Icons.arrow_back_ios_new_rounded,
                    onTap: () => Navigator.pop(context),
                  ),
                ),
                actions: [
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: IconBtn(
                      icon: Icons.share_rounded,
                      onTap: () {},
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColor.blueColor(context).withOpacity(0.15),
                          AppColor.scaffoldColor(context),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.directions_car_filled_rounded,
                        size: 120.sp,
                        color: AppColor.blueColor(context).withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
              ),

              // ── Body ────────────────────────────────────────────────────
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 120.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Status & ID
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: availabilityColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              car.availabilityLabel,
                              style: TextStyle(
                                color: availabilityColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            'ID: #${car.id.padLeft(6, '0')}',
                            style: TextStyle(
                              color: AppColor.greyColor(context),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),

                      /// Brand & Name
                      Text(
                        car.brand,
                        style: TextStyle(
                          color: AppColor.blueColor(context),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1.2,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        car.name,
                        style: TextStyle(
                          color: AppColor.blackTextColor(context),
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                      Gap(12.h),

                      /// Price
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            NumberFormat('#,##0').format(car.price),
                            style: TextStyle(
                              color: AppColor.blackTextColor(context),
                              fontSize: 32.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Gap(6.w),
                          Text(
                            'ر.س',
                            style: TextStyle(
                              color: AppColor.greyColor(context),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),

                      Gap(32.h),

                      /// Specs Grid
                      Text(
                        'المواصفات الرئيسية',
                        style: TextStyle(
                          color: AppColor.blackTextColor(context),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Gap(16.h),
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 12.h,
                        crossAxisSpacing: 12.w,
                        childAspectRatio: 2.2,
                        children: [
                          _SpecCard(
                            icon: Icons.calendar_today_rounded,
                            label: 'سنة الصنع',
                            value: car.year,
                          ),
                          _SpecCard(
                            icon: Icons.speed_rounded,
                            label: 'المسافة',
                            value: '${car.mileage} كم',
                          ),
                          _SpecCard(
                            icon: Icons.palette_rounded,
                            label: 'اللون',
                            value: car.color,
                          ),
                          _SpecCard(
                            icon: Icons.settings_rounded,
                            label: 'ناقل الحركة',
                            value: 'أوتوماتيك',
                          ),
                        ],
                      ),

                      Gap(32.h),

                      /// Description Mock
                      Text(
                        'نبذة عن السيارة',
                        style: TextStyle(
                          color: AppColor.blackTextColor(context),
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Gap(12.h),
                      Text(
                        'سيارة ${car.name} بحالة ممتازة، خاضعة لجميع فحوصات الجودة. تتميز بكفاءة عالية في استهلاك الوقود وتقنيات أمان متطورة تناسب احتياجات العميل اليومية.',
                        style: TextStyle(
                          color: AppColor.greyColor(context).withOpacity(0.8),
                          fontSize: 14.sp,
                          height: 1.6,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          /// ── Bottom Action ──────────────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 34.h),
              decoration: BoxDecoration(
                color: AppColor.scaffoldColor(context),
                border: Border(top: BorderSide(color: AppColor.borderColor(context), width: 1)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueColor(context),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  elevation: 0,
                ),
                child: Text(
                  'حجز للعميل',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SpecCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SpecCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColor.borderColor(context).withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColor.blueColor(context).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: AppColor.blueColor(context), size: 20.sp),
          ),
          Gap(10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: AppColor.greyColor(context),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
