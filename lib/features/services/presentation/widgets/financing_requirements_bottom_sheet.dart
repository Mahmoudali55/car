import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';

class FinancingRequirementsBottomSheet extends StatelessWidget {
  const FinancingRequirementsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.scaffoldColor(context),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          // Header
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'متطلبات التمويل والوثائق المطلوبة',
                    style: AppTextStyle.titleMedium(context).copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 16.sp,
                      color: AppColor.primaryColor(context),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: AppColor.borderColor(context),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 16.sp, color: AppColor.blackTextColor(context)),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Financing requirements section
                  Text(
                    'متطلبات التمويل:',
                    style: AppTextStyle.titleSmall(context).copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  Gap(16.h),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColor.cardColor(context),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColor.borderColor(context)),
                    ),
                    child: Column(
                      children: [
                        _buildRequirementRow(
                          context,
                          icon: Icons.person_outline_rounded,
                          title: 'عمر العميل',
                          value: 'من 18 حتى 65 سنة',
                          isLast: false,
                        ),
                        _buildRequirementRow(
                          context,
                          icon: Icons.credit_card_rounded,
                          title: 'رخصة القيادة',
                          value: 'سارية المفعول',
                          isLast: false,
                        ),
                        _buildRequirementRow(
                          context,
                          icon: Icons.receipt_long_rounded,
                          title: 'المخالفات المرورية',
                          value: 'يُمنع وجود أى مخالفة',
                          isLast: true,
                        ),
                      ],
                    ),
                  ),
                  Gap(24.h),
                  // Required documents section
                  Text(
                    'الوثائق المطلوبة:',
                    style: AppTextStyle.titleSmall(context).copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColor.blackTextColor(context),
                    ),
                  ),
                  Gap(16.h),
                  _buildDocumentItem(context, 'الحد الأدنى للراتب: 2500 ريال.'),
                  Gap(12.h),
                  _buildDocumentItem(context, 'لا يشترط تحويل الراتب الى البنك.'),
                  Gap(12.h),
                  _buildDocumentItem(context, 'الجهة العاملة لا يجب أن تكون معتمدة لدى شركات التمويل.'),
                  Gap(12.h),
                  _buildDocumentItem(
                    context,
                    'بدون دفعة أولى. "يخضع للتقييم الائتماني عند تقديم الطلب"',
                  ),
                  Gap(12.h),
                  _buildDocumentItem(context, 'دفعة أخيرة قد تصل إلى 45%.'),
                  Gap(24.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirementRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required bool isLast,
  }) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: AppColor.primaryColor(context), size: 18.sp),
              ),
              Gap(12.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodyMedium(context).copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColor.blackTextColor(context),
                  ),
                ),
              ),
              Text(
                value,
                style: AppTextStyle.bodySmall(context).copyWith(
                  color: AppColor.greyColor(context),
                  fontSize: 12.sp,
                ),
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, color: AppColor.dividerColor(context), indent: 16.w, endIndent: 16.w),
      ],
    );
  }

  Widget _buildDocumentItem(BuildContext context, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle_rounded, color: AppColor.greenColor(context), size: 20.sp),
        Gap(10.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.bodyMedium(context).copyWith(
              color: AppColor.blackTextColor(context),
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
