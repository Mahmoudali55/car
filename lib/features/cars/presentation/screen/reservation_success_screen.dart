import 'package:car/core/custom_widgets/buttons/custom_button.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ReservationSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> car;
  final String paymentMethod;

  const ReservationSuccessScreen({
    super.key,
    required this.car,
    required this.paymentMethod,
  });

  @override
  Widget build(BuildContext context) {
    final bool isFinancingFlow =
        paymentMethod == 'tamara' || paymentMethod == 'bank';

    final String methodLabel = paymentMethod == 'tamara'
        ? 'تمارا'
        : paymentMethod == 'bank'
            ? 'بطاقة الراجحي / الأهلي'
            : 'الكاش';

    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: AppBar(
        backgroundColor: AppColor.appBarColor(context),
        elevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () {
              // Pop all the way back to root
              Navigator.of(context).popUntil((r) => r.isFirst);
            },
            child: Text(
              'إلغاء',
              style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 13.sp),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            // Success icon
            Gap(40.h),
            Container(
              width: 100.w,
              height: 100.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff00c853).withOpacity(0.1),
              ),
              child: Icon(
                Icons.check_circle_rounded,
                color: const Color(0xff00c853),
                size: 64.sp,
              ),
            ),
            Gap(32.h),
            Text(
              'تم تقديم طلبك بنجاح! 🎉',
              style: AppTextStyle.titleMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 24.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(12.h),
            Text(
              'سيقوم فريقنا بمراجعة طلبك والتواصل معك في أقرب وقت ممكن.',
              style: AppTextStyle.bodySmall(context).copyWith(
                color: AppColor.blackTextColor(context).withOpacity(0.5),
                height: 1.6,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
            Gap(48.h),

            // Order summary card
            _buildInfoCard(context, [
              _InfoRow(
                icon: Icons.directions_car_filled_rounded,
                iconColor: AppColor.primaryColor(context),
                label: 'السيارة',
                value: car['name'] ?? '—',
              ),
              _InfoRow(
                icon: Icons.payment_rounded,
                iconColor: const Color(0xFF3F51B5),
                label: 'طريقة الدفع',
                value: methodLabel,
              ),
              if (!isFinancingFlow)
                const _InfoRow(
                  icon: Icons.lock_clock_rounded,
                  iconColor: Colors.orange,
                  label: 'مبلغ العربون',
                  value: '500 ر.س (مسترد)',
                ),
              const _InfoRow(
                icon: Icons.info_outline_rounded,
                iconColor: Colors.grey,
                label: 'حالة الطلب',
                value: 'قيد المراجعة',
              ),
            ]),

            Gap(32.h),

            // Whatsapp notice
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xffc8e6c9)),
              ),
              child: Row(
                children: [
                  Icon(Icons.phone,
                      color: const Color(0xff25D366), size: 28.sp),
                  Gap(16.w),
                  Expanded(
                    child: Text(
                      'ستصلك رسالة تأكيد على واتساب خلال لحظات.',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: const Color(0xFF2E7D32),
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Gap(48.h),

            // Actions
            CustomButton(
              height: 56.h,
              width: double.infinity,
              radius: 14.r,
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
              child: Text(
                'العودة للرئيسية',
                style: AppTextStyle.buttonStyle(context).copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            ),
            Gap(16.h),
            TextButton(
              onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
              child: Text(
                'تصفح سيارات أخرى',
                style: TextStyle(
                  color: AppColor.primaryColor(context),
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
            Gap(40.h),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, List<_InfoRow> rows) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.cardColor(context),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColor.borderColor(context)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: List.generate(rows.length, (i) {
          final row = rows[i];
          final bool isLast = i == rows.length - 1;
          return Column(
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                child: Row(
                  children: [
                    Container(
                      width: 38.w,
                      height: 38.w,
                      decoration: BoxDecoration(
                        color: row.iconColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Icon(row.icon, color: row.iconColor, size: 18.sp),
                    ),
                    Gap(14.w),
                    Expanded(
                      child: Text(
                        row.label,
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.blackTextColor(context).withOpacity(0.5),
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    Text(
                      row.value,
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
              if (!isLast)
                Container(
                  height: 1,
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  color: AppColor.borderColor(context).withOpacity(0.5),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class _InfoRow {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
  });
}
