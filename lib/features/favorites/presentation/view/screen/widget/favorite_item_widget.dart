import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: AppColor.secondAppColor(context),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColor.blackColor(context).withValues(alpha: 0.06),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.04)),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            NavigatorMethods.pushNamed(
              context,
              RoutesName.carDetailsScreen,
              arguments: {
                'car': car,
                'heroTag': 'fav_car_image_${car['itemCode'] ?? car['name'] ?? 'unknown'}',
              },
            );
          },
          child: Padding(
            padding: EdgeInsets.all(8.w),
            child: Row(
              children: [
                Container(
                  width: 110.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    color: AppColor.blackTextColor(context).withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Hero(
                    tag: 'fav_car_image_${car['itemCode'] ?? car['name'] ?? 'unknown'}',
                    child: car['image'] != null && car['image'].toString().trim().startsWith('http')
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: CustomNetworkImage(
                              imageUrl: car['image'].toString(),
                              fit: BoxFit.cover,
                              height: 90.h,
                              width: 110.w,
                            ),
                          )
                        : car['image'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
                            child: Image.asset(
                              car['image'].toString(),
                              fit: BoxFit.cover,
                              height: double.infinity,
                              width: 110.w,
                            ),
                          )
                        : Icon(
                            Icons.directions_car_rounded,
                            size: 40.h,
                            color: AppColor.greyColor(context).withValues(alpha: 0.5),
                          ),
                  ),
                ),
                Gap(14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        car['brand'] ?? '',
                        style: AppTextStyle.bodySmall(
                          context,
                        ).copyWith(color: AppColor.primaryColor(context), fontWeight: FontWeight.bold),
                      ),
                      Gap(4.h),
                      Text(
                        car['name'] ?? '',
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.blackTextColor(context),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(8.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          car['price'] ?? '',
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColor.primaryColor(context),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 4.w, right: 8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColor.redColor(context).withValues(alpha: 0.08),
                  ),
                  child: IconButton(
                    onPressed: () {
                      context.read<FavoritesCubit>().toggleFavorite(car);
                    },
                    icon: Icon(Icons.favorite_rounded, color: AppColor.redColor(context), size: 22.sp),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
