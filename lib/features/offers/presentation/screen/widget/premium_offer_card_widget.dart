import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/offers/presentation/screen/widget/custom_item_offer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PremiumOfferCardWidget extends StatelessWidget {
  const PremiumOfferCardWidget({super.key, required this.offer});
  final Map<String, dynamic> offer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: offer),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.25,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor(context).withValues(alpha: 0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background Brand Name - Subtle
            Positioned(
              left: -10,
              bottom: -10,
              child: Opacity(
                opacity: 0.02,
                child: Text(
                  offer['brand'] ?? '',
                  style: AppTextStyle.titleLarge(context).copyWith(
                    color: AppColor.blackTextColor(context),
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            CustomItemOfferWidget(offer: offer),
            Positioned(
              left: 40.w,
              top: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: AppColor.primaryColor(context),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(12.r)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      offer['discount'],
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.whiteColor(context),
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'OFF',
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.whiteColor(context).withValues(alpha: 0.8),
                        fontSize: 8.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
