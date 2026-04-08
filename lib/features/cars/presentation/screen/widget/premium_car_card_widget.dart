import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumCarCardWidget extends StatelessWidget {
  final Map<String, dynamic> car;
  const PremiumCarCardWidget({super.key, required this.car});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.05)),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Stack(
              children: [
                // Car Image
                Container(
                  height: 160.h,
                  width: double.infinity,
                  padding: EdgeInsets.all(20.w),

                  child: Hero(
                    tag: 'car_image_${car['name']}',
                    child: Center(
                      child: Image.asset(car['image'], fit: BoxFit.contain, height: 150.h),
                    ),
                  ),
                ),
                // Badges
                Positioned(
                  top: 10.h,
                  left: -10.w,
                  child: Container(
                    height: 30.h,
                    width: 80.w,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      car['year'],
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.blackTextColor(context),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  right: 10.w,
                  child: Row(
                    children: [
                      _buildCompareButton(context),
                      Gap(8.w),
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = context.read<FavoritesCubit>().isFavorite(car['name']!);
                          return Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.read<FavoritesCubit>().toggleFavorite(car);
                              },
                              icon: Icon(
                                isFav ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                                color: isFav
                                    ? AppColor.redColor(context)
                                    : AppColor.blackTextColor(context),
                                size: 20.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            car['brand'],
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Gap(4.h),
                          Text(
                            car['name'],
                            style: AppTextStyle.bodyMedium(context).copyWith(
                              color: AppColor.blackTextColor(context),
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        car['price'],
                        style: AppTextStyle.titleMedium(context).copyWith(
                          color: AppColor.primaryColor(context),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Gap(12.h),
                  Divider(
                    color: AppColor.blackTextColor(context).withValues(alpha: (0.05)),
                    height: 1,
                  ),
                  Gap(12.h),
                  Row(
                    children: [
                      _buildSpecIcon(context, Icons.speed_rounded, car['mileage']),
                      Gap(16.w),
                      _buildSpecIcon(context, Icons.settings_rounded, AppLocaleKey.normal.tr()),
                      Gap(16.w),
                      _buildSpecIcon(
                        context,
                        Icons.local_gas_station_rounded,
                        AppLocaleKey.petrol.tr(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCompareButton(BuildContext context) {
    return Container(
      height: 30.h,
      decoration: BoxDecoration(
        color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // Note: Since this is a StatelessWidget, we rely on the parent or global state
          // to refresh if needed, but the button itself uses Hive directly.
          if (HiveMethods.isInComparison(car['name'])) {
            HiveMethods.removeFromComparison(car['name']);
            // Forces immediate UI update in the widget tree for this card
            (context as Element).markNeedsBuild();
          } else {
            bool added = HiveMethods.addToComparison(car);
            if (added) {
              // Forces immediate UI update in the widget tree for this card
              (context as Element).markNeedsBuild();
            } else {
              CommonMethods.showToast(
                message: AppLocaleKey.compare_list_full.tr(),
                type: ToastType.error,
              );
            }
          }
        },
        icon: Icon(
          HiveMethods.isInComparison(car['name'])
              ? Icons.compare_arrows_rounded
              : Icons.add_chart_rounded,
          color: HiveMethods.isInComparison(car['name'])
              ? AppColor.primaryColor(context)
              : AppColor.blackTextColor(context),
          size: 18.sp,
        ),
      ),
    );
  }

  Widget _buildSpecIcon(BuildContext context, IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: AppColor.blackTextColor(context), size: 14.sp),
        Gap(4.w),
        Text(
          text,
          style: AppTextStyle.bodyMedium(
            context,
          ).copyWith(color: AppColor.blackTextColor(context), fontSize: 10.sp),
        ),
      ],
    );
  }
}
