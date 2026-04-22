import 'package:car/features/agent/presentation/screens/widget/comm_row_widget.dart';
import 'package:car/features/agent/presentation/screens/widget/funnel_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AgentPerformanceScreen extends StatelessWidget {
  const AgentPerformanceScreen({super.key});

  static const _kNavy = Color(0xFF0A1628);
  static const _kGold = Color(0xFFFFD700);
  static const _kBlue = Color(0xFF1565C0);

  // Mock weekly data
  static const _weeklyData = [4, 6, 3, 8, 5, 7, 4];
  static const _weekDays = ['س', 'ح', 'إ', 'ث', 'أ', 'خ', 'ج'];
  static const _maxBar = 10;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: _kNavy,
        elevation: 0,
        title: Text('الأداء والإحصاءات', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 20.sp)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 18.sp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Tier Badge ─────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0A1628), Color(0xFF1565C0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64.w,
                    height: 64.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _kGold.withOpacity(0.15),
                      border: Border.all(color: _kGold.withOpacity(0.4), width: 2),
                    ),
                    child: Icon(Icons.star_rounded, color: _kGold, size: 32.sp),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('مندوب ذهبي', style: TextStyle(color: _kGold, fontWeight: FontWeight.w900, fontSize: 20.sp)),
                        Text('المرتبة 3 من 24 مندوب', style: TextStyle(color: Colors.white60, fontSize: 12.sp)),
                        Gap(8.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: 0.72,
                            backgroundColor: Colors.white12,
                            valueColor: const AlwaysStoppedAnimation<Color>(_kGold),
                            minHeight: 6.h,
                          ),
                        ),
                        Gap(4.h),
                        Text('72% للوصول لمستوى بلاتيني', style: TextStyle(color: Colors.white38, fontSize: 10.sp)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Gap(28.h),

            // ── Weekly Chart ───────────────────────────────────────────────
            Text('أداء الأسبوع', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: _kNavy)),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0,4))],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(7, (i) {
                  final h = (_weeklyData[i] / _maxBar * 100.h).clamp(12.0, 100.0);
                  final isMax = _weeklyData[i] == _weeklyData.reduce((a, b) => a > b ? a : b);
                  return Column(
                    children: [
                      if (isMax)
                        Container(
                          margin: EdgeInsets.only(bottom: 4.h),
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(color: _kGold, borderRadius: BorderRadius.circular(6.r)),
                          child: Text('${_weeklyData[i]}', style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: _kNavy)),
                        )
                      else
                        Gap(20.h),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 600),
                        width: 32.w,
                        height: h,
                        decoration: BoxDecoration(
                          color: isMax ? _kBlue : _kBlue.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      Gap(8.h),
                      Text(_weekDays[i], style: TextStyle(fontSize: 11.sp, color: Colors.grey, fontWeight: FontWeight.bold)),
                    ],
                  );
                }),
              ),
            ),
            Gap(28.h),

            // ── Conversion Funnel ──────────────────────────────────────────
            Text('قمع التحويل', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: _kNavy)),
            Gap(16.h),
            const FunnelRow(label: 'عملاء محتملون', count: 32, total: 32, color: _kBlue),
            Gap(8.h),
            const FunnelRow(label: 'زيارات / عروض', count: 18, total: 32, color: Color(0xFF7B1FA2)),
            Gap(8.h),
            const FunnelRow(label: 'صفقات مغلقة', count: 7, total: 32, color: Color(0xFF2E7D32)),
            Gap(28.h),

            // ── Commission ─────────────────────────────────────────────────
            Text('العمولات', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18.sp, color: _kNavy)),
            Gap(16.h),
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10)],
              ),
              child: Column(
                children: [
                  const CommRow(label: 'عمولة هذا الشهر', value: '15,625 ر.س', color: Color(0xFF2E7D32)),
                  Divider(height: 24.h, color: Colors.grey.shade100),
                  const CommRow(label: 'إجمالي هذا الربع', value: '41,200 ر.س', color: _kBlue),
                  Divider(height: 24.h, color: Colors.grey.shade100),
                  const CommRow(label: 'هدف الشهر', value: '20,000 ر.س', color: Colors.grey),
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



