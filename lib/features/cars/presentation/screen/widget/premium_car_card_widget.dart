import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/cars/presentation/widget/bank_installments_banner_widget.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumCarCardWidget extends StatelessWidget {
  final Map<String, dynamic> car;
  final String? heroTag;
  const PremiumCarCardWidget({super.key, required this.car, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen,
            arguments: {'car': car, 'heroTag': heroTag});
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: heroTag ?? 'car_image_${car['itemCode'] ?? car['name']}',
                  child: car['image'] != null && car['image'].toString().startsWith('http')
                      ? CustomNetworkImage(
                          imageUrl: car['image'],
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 150.h,
                        )
                      : Image.asset(
                          car['image'] ?? 'assets/images/car.jpeg',
                          fit: BoxFit.fill,
                          height: 150.h,
                          width: double.infinity,
                        ),
                ),
                // Badges
                Positioned(
                  top: 10.h,
                  left: -5.w,
                  child: Container(
                    height: 25.h,
                    width: 60.w,
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 15.w),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColor.blackTextColor(context).withOpacity(0.1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      car['year']?.toString() ?? '',
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
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = context.read<FavoritesCubit>().isFavorite(
                            car['name']?.toString() ?? '',
                          );
                          return Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: AppColor.blackTextColor(context).withOpacity(0.1),
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
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        car['name']?.toString() ?? '',
                        style: AppTextStyle.bodyMedium(context).copyWith(
                          color: AppColor.blackTextColor(context),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Gap(10.w),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColor.whiteColor(context),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColor.greyColor(context).withValues(alpha: 0.1)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColor.blackColor(context).withValues(alpha: 0.02),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        children: [
                          // Cash Price (Right)
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocaleKey.cash.tr(),
                                  style: AppTextStyle.bodySmall(context).copyWith(
                                    color: AppColor.blackColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(6.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      car['price']?.toString().replaceAll(RegExp(r'[^0-9,]'), '') ??
                                          '---',
                                      style: AppTextStyle.titleMedium(context).copyWith(
                                        color: AppColor.greenColor(context),
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Gap(4.w),
                                    Text(
                                      AppLocaleKey.aed.tr(),
                                      style: AppTextStyle.bodySmall(context).copyWith(
                                        color: AppColor.greenColor(context),
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  AppLocaleKey.agentIncludesVat.tr(),
                                  style: AppTextStyle.bodySmall(context),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(color: AppColor.greyColor(context), width: 32.w),
                          car['installments'] == null
                              ? Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => BankInstallmentsBannerWidget(car: car),
                                        ),
                                      );
                                    },
                                    child: BankInstallmentsBannerWidget(car: car),
                                  ),
                                )
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ),
                  ),
                  Gap(12.h),
                  Divider(color: AppColor.blackTextColor(context).withOpacity((0.05)), height: 1),
                  Gap(12.h),
                  Row(
                    children: [
                      _buildSpecIcon(
                        context,
                        Icons.speed_rounded,
                        car['mileage']?.toString() ?? '',
                      ),
                      Gap(16.w),
                      _buildSpecIcon(context, Icons.settings_rounded, AppLocaleKey.normal.tr()),
                      Gap(16.w),
                      _buildSpecIcon(
                        context,
                        Icons.local_gas_station_rounded,
                        AppLocaleKey.petrol.tr(),
                      ),
                      Spacer(),
                      _buildCompareButton(context),
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
        color: AppColor.blackTextColor(context).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          // Note: Since this is a StatelessWidget, we rely on the parent or global state
          // to refresh if needed, but the button itself uses Hive directly.
          final carName = car['name']?.toString() ?? '';
          if (carName.isEmpty) return;

          if (HiveMethods.isInComparison(carName)) {
            HiveMethods.removeFromComparison(carName);
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
          HiveMethods.isInComparison(car['name']?.toString() ?? '')
              ? Icons.compare_arrows_rounded
              : Icons.add_chart_rounded,
          color: HiveMethods.isInComparison(car['name']?.toString() ?? '')
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
