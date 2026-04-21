import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PricingDetailsBottomSheet extends StatelessWidget {
  final Map<String, dynamic> car;
  final double totalPrice;

  const PricingDetailsBottomSheet({
    super.key,
    required this.car,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'إعرض التفاصيل',
                style: AppTextStyle.titleMedium(context).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 22.sp,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          Gap(24.h),
          Container(height: 1, color: AppColor.borderColor(context).withOpacity(0.5)),
          Gap(24.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  car['name'] ?? 'Car Name',
                  style: AppTextStyle.titleMedium(context).copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  car['image'] ?? 'https://via.placeholder.com/100',
                  height: 80.h,
                  width: 120.w,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    height: 80.h,
                    width: 120.w,
                    color: Colors.grey[200],
                    child: const Icon(Icons.directions_car_filled_rounded, color: Colors.grey),
                  ),
                ),
              ),
            ],
          ),
          Gap(32.h),
          _buildPriceItem('قيمة السيارة', '43,100',context),
          Gap(24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ضمان سيارة',
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      color: AppColor.blackTextColor(context).withOpacity(0.7),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '6 أشهر او 10 ألف كم',
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: Colors.grey,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
              Text(
                'مجاناً',
                style: TextStyle(
                  color: const Color(0xff00c853),
                  fontWeight: FontWeight.w900,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          Gap(24.h),
          _buildPriceItem('التسجيل واللوحات', '875',context),
          Gap(24.h),
          _buildPriceItem('كلفة الشحن', '225',context),
          Gap(24.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPriceItem('الضريبة المضافة على الخدمات', '138.75',context),
              Gap(4.h),
              Text(
                'تشمل رسوم التسجيل و اللوحات و كلفة الشحن\nنسبة القيمة المضافة خاضعة لتعديل بموجب القانون',
                style: TextStyle(
                  fontSize: 9.sp,
                  color: Colors.grey,
                  height: 1.5,
                ),
              ),
            ],
          ),
          Gap(32.h),
          Container(height: 1, color: AppColor.borderColor(context).withOpacity(0.5)),
          Gap(32.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المبلغ الإجمالي',
                style: AppTextStyle.titleMedium(context).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 18.sp,
                ),
              ),
              Text(
                '${totalPrice.toStringAsFixed(2)} SAR',
                style: AppTextStyle.titleMedium(context).copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 22.sp,
                ),
              ),
            ],
          ),
          Gap(24.h),
        ],
      ),
    );
  }

  Widget _buildPriceItem(String label, String value,BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyMedium(context).copyWith(
            color: AppColor.blackTextColor(context).withOpacity(0.7),
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            Text(
              value,
              style: AppTextStyle.bodyMedium(context).copyWith(
                fontWeight: FontWeight.w900,
                fontSize: 16.sp,
              ),
            ),
            Gap(8.w),
            Icon(Icons.payments_outlined, color: AppColor.blackTextColor(context), size: 18.sp),
          ],
        ),
      ],
    );
  }
}
