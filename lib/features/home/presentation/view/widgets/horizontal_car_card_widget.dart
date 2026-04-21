import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/home/presentation/view/widgets/custom_price_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HorizontalCarCardWidget extends StatelessWidget {
  final Map<String, dynamic> car;
  final VoidCallback? onTap;

  const HorizontalCarCardWidget({
    super.key,
    required this.car,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
      },
      child: Container(
        width: 320.w,
        height: 150.h,
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColor.blackTextColor(context).withOpacity(0.05),
          ),
        ),
        child: Column(
          children: [
            // Left Side: Image
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(
                color: AppColor.blackTextColor(context).withOpacity(0.02),
                borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(20.r),
              ),
            ),
              padding: EdgeInsets.all(12.w),
              child: Hero(
                tag: 'budget_car_${car['name']}',
          child: Image.asset(
            car['image'] ?? 'assets/images/cars/mercedes-benz.png',
                  fit: BoxFit.contain,
            ),
          ),
        ),

            // Right Side: Details
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(
                      car['name'] ?? '',
                      style: AppTextStyle.titleSmall(context).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
              ),
                    Gap(30.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomPriceWidget(car: car, title: AppLocaleKey.cash.tr(), price: car['cashPrice'] ?? '',),
                         Gap(4.h),
                         Container(
                          width: 3.w,
                          height: 30.h,
                          color: AppColor.blackTextColor(context)
                          
                        ),
                          Gap(4.h),
                   GestureDetector(
                            onTap: () {
                             Navigator.pushNamed(context, RoutesName.financingScreen, arguments: car);
                            },
                    child: CustomPriceWidget(car: car, title: AppLocaleKey.installments.tr(), price: car['installmentPrice'] ?? '',)),
                      ],
                    ),
                   
                    const Spacer(),
                    if (car['isTamaraAvailable'] == true)
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset( 'assets/images/tamara.jpeg', width: 60.w, height: 20.h, fit: BoxFit.contain),
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

