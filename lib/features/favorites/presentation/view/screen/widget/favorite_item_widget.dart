import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FavoriteItemWidget extends StatelessWidget {
  const FavoriteItemWidget({super.key, required this.car});
  final Map<String, dynamic> car;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(
          context,
          RoutesName.carDetailsScreen,
          arguments: car,
        );
      },
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: AppColor.blackTextColor(context).withOpacity(0.04)),
        ),
        child: Row(
          children: [
            /// Car Image
            Container(
              width: 100.w,
              height: 80.h,
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: AppColor.blackTextColor(context).withOpacity(0.05),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Hero(
                tag: 'car_image_${car['name']}',
                child: Image.asset(car['image'], fit: BoxFit.contain),
              ),
            ),

            Gap(14.w),

            /// Car Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Brand
                  Text(
                    car['brand'],
                    style: AppTextStyle.bodySmall(context).copyWith(
                      color: AppColor.primaryColor(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  Gap(4.h),

                  /// Name
                  Text(
                    car['name'],
                    style: AppTextStyle.bodyMedium(context).copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColor.blackTextColor(context),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),

                  Gap(8.h),

                  /// Price
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.primaryColor(context).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      car['price'],
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /// Favorite Button
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red.withOpacity(0.1),
              ),
              child: IconButton(
                onPressed: () {
                  context.read<FavoritesCubit>().toggleFavorite(car);
                },
                icon: Icon(Icons.favorite, color: Colors.redAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
