import 'package:animate_do/animate_do.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ManageBookingsScreen extends StatelessWidget {
  const ManageBookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                ),
              )
            : null,
        title: Text(
          'إدارة العمليات والرحلات 🗓️',
          style: AppTextStyle.titleMedium(context).copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              indicatorColor: AppColor.primaryColor(context),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.4),
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: 'قيد الانتظار'),
                Tab(text: 'نشطة حالياً'),
                Tab(text: 'تمت'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildBookingsList(context, 'pending'),
                  _buildBookingsList(context, 'active'),
                  _buildBookingsList(context, 'completed'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBookingsList(BuildContext context, String type) {
    return ListView.separated(
      padding: EdgeInsets.all(20.w),
      itemCount: 5,
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, index) => Gap(16.h),
      itemBuilder: (context, index) => FadeInUp(
        delay: Duration(milliseconds: index * 50),
        child: _buildBookingProCard(context, index, type),
      ),
    );
  }

  Widget _buildBookingProCard(BuildContext context, int index, String type) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Icon(
                  Icons.car_rental_rounded,
                  color: AppColor.primaryColor(context),
                  size: 30.sp,
                ),
              ),
              Gap(16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'بنتلي كونتيننتال GT',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Gap(4.h),
                    Text(
                      'العميل: محمد الجاسر',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.4),
                        fontSize: 11.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '2,400 د.إ',
                    style: TextStyle(
                      color: Colors.greenAccent,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'دفع ناجح',
                    style: TextStyle(
                      color: Colors.greenAccent.withOpacity(0.5),
                      fontSize: 9.sp,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Gap(16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoTag(Icons.access_time_filled_rounded, '12-25 مارس'),
              if (type == 'pending') ...[
                Row(
                  children: [
                    _buildQuickAction(Icons.close_rounded, Colors.redAccent),
                    Gap(8.w),
                    _buildQuickAction(Icons.check_rounded, Colors.greenAccent),
                  ],
                ),
              ] else
                _buildTypeBadge(type),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTag(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, color: Colors.white.withOpacity(0.3), size: 14.sp),
        Gap(6.w),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.5),
            fontSize: 11.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAction(IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: color, size: 18.sp),
    );
  }

  Widget _buildTypeBadge(String type) {
    final isDone = type == 'completed';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: (isDone ? Colors.blueAccent : Colors.orangeAccent).withOpacity(
          0.1,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        isDone ? 'منتهية' : 'نشطة',
        style: TextStyle(
          color: isDone ? Colors.blueAccent : Colors.orangeAccent,
          fontSize: 10.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
