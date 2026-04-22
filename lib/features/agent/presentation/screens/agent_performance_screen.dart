import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/agent/data/agent_models.dart';
import 'package:car/features/agent/presentation/screens/widget/comm_row_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/funnel_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentPerformanceScreen extends StatelessWidget {
  const AgentPerformanceScreen({super.key});

  // Mock weekly data
  static const _weeklyData = [4, 6, 3, 8, 5, 7, 4];
  static const _weekDays = ['س', 'ح', 'إ', 'ث', 'أ', 'خ', 'ج'];
  static const _maxBar = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        centerTitle: false,
        title: Text('الأداء والإحصاءات',
            style: TextStyle(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900, fontSize: 20.sp)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: AppColor.blackTextColor(context), size: 18.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Tier Badge ─────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColor.blueColor(context),
                    AppColor.blueColor(context).withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.blueColor(context).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                      border: Border.all(color: Colors.white.withOpacity(0.4), width: 2),
                    ),
                    child: Icon(Icons.star_rounded, color: AppColor.goldColor(context), size: 32.sp),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('مندوب ذهبي',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.sp)),
                        Text('المرتبة 3 من 24 مندوب',
                            style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12.sp, fontWeight: FontWeight.w600)),
                        Gap(10.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6.r),
                          child: LinearProgressIndicator(
                            value: 0.72,
                            backgroundColor: Colors.white.withOpacity(0.2),
                            valueColor: AlwaysStoppedAnimation<Color>(AppColor.goldColor(context)),
                            minHeight: 8.h,
                          ),
                        ),
                        Gap(6.h),
                        Text('72% للوصول لمستوى بلاتيني',
                            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 10.sp, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(32.h),

            // ── Weekly Chart ───────────────────────────────────────────────
            Text('أداء الأسبوع',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: AppColor.blackTextColor(context))),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColor.borderColor(context).withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (i) {
                  final h = (_weeklyData[i] / _maxBar * 110.h).clamp(15.0, 110.0);
                  final isMax = _weeklyData[i] == _weeklyData.reduce((a, b) => a > b ? a : b);
                  return Column(
                    children: [
                      if (isMax)
                        Container(
                          margin: EdgeInsets.only(bottom: 6.h),
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                              color: AppColor.goldColor(context), borderRadius: BorderRadius.circular(8.r)),
                          child: Text('${_weeklyData[i]}',
                              style: TextStyle(
                                  fontSize: 10.sp, fontWeight: FontWeight.w900, color: Colors.white)),
                        )
                      else
                        Gap(24.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.elasticOut,
                        width: 34.w,
                        height: h,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: isMax
                                ? [AppColor.blueColor(context), AppColor.blueColor(context).withOpacity(0.7)]
                                : [AppColor.blueColor(context).withOpacity(0.2), AppColor.blueColor(context).withOpacity(0.1)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      Gap(10.h),
                      Text(_weekDays[i],
                          style: TextStyle(
                              fontSize: 12.sp,
                              color: AppColor.hintColor(context),
                              fontWeight: FontWeight.w700)),
                    ],
                  );
                }),
              ),
            ),
            Gap(32.h),

            // ── Conversion Funnel ──────────────────────────────────────────
            Text('قمع التحويل',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: AppColor.blackTextColor(context))),
            Gap(16.h),
            FunnelRow(label: 'عملاء محتملون', count: 32, total: 32, color: AppColor.blueColor(context)),
            Gap(10.h),
            FunnelRow(label: 'زيارات / عروض', count: 18, total: 32, color: const Color(0xFF8B5CF6)),
            Gap(10.h),
            FunnelRow(label: 'صفقات مغلقة', count: 7, total: 32, color: AppColor.greenColor(context)),
            Gap(32.h),

            // ── Commission ─────────────────────────────────────────────────
            Text('العمولات والمبيعات',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: AppColor.blackTextColor(context))),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: AppColor.cardColor(context),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: AppColor.borderColor(context).withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))
                ],
              ),
              child: Column(
                children: [
                  CommRow(label: 'عمولة هذا الشهر', value: '15,625 ر.س', color: AppColor.greenColor(context)),
                  Divider(height: 32.h, color: AppColor.borderColor(context)),
                  CommRow(label: 'إجمالي هذا الربع', value: '41,200 ر.س', color: AppColor.blueColor(context)),
                  Divider(height: 32.h, color: AppColor.borderColor(context)),
                  CommRow(label: 'هدف الشهر', value: '20,000 ر.س', color: AppColor.hintColor(context)),
                ],
              ),
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }
}



