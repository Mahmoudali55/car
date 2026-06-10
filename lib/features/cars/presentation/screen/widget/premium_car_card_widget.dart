import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/custom_widgets/custom_toast/custom_toast.dart';
import 'package:car/core/images/app_images.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/common_methods.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/cars/presentation/widget/bank_installments_banner_widget.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PremiumCarCardWidget extends StatelessWidget {
  final GetBrandCarsDataModel car;
  final String? heroTag;
  const PremiumCarCardWidget({super.key, required this.car, this.heroTag});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(
          context,
          RoutesName.carDetailsScreen,
          arguments: {'car': car, 'heroTag': heroTag},
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        color: AppColor.secondAppColor(context),
        child: Column(
          children: [
            Stack(
              children: [
                Hero(
                  tag: heroTag ?? 'car_image_${car.itemCode}',
                  child: car.fullCarImage.isNotEmpty && car.fullCarImage.startsWith('http')
                      ? CustomNetworkImage(
                          imageUrl: car.fullCarImage,
                          fit: BoxFit.fill,
                          width: double.infinity,
                          height: 150.h,
                        )
                      : Image.asset(
                          car.fullCarImage.isNotEmpty
                              ? car.fullCarImage
                              : AppImages.assetsImagesCar,
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
                      color: AppColor.blackColor(context).withValues(alpha: 0.1),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      car.makeYear.toString(),
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
                          final isFav = context.read<FavoritesCubit>().isFavorite(car.itemName);
                          return Container(
                            height: 30.h,
                            decoration: BoxDecoration(
                              color: AppColor.blackColor(context).withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () {
                                context.read<FavoritesCubit>().toggleFavorite(car.toMap());
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
                        car.itemName,
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
                                    color: AppColor.blackTextColor(context),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Gap(6.h),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Flexible(
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          car.formattedPrice,
                                          style: AppTextStyle.titleMedium(context).copyWith(
                                            color: AppColor.greenColor(context),
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Gap(4.w),
                                    SvgPicture.asset(
                                      AppImages.sar,
                                      height: 16.h,
                                      width: 16.w,
                                      colorFilter: ColorFilter.mode(
                                        AppColor.greenColor(context),
                                        BlendMode.srcIn,
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
                          car.installments == null
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
                  Row(
                    children: [
                      _buildSpecIcon(context, Icons.speed_rounded, car.kilometerReading ?? '0'),
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
        color: AppColor.blackTextColor(context).withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          final carName = car.itemName;
          if (carName.isEmpty) return;

          if (HiveMethods.isInComparison(carName)) {
            HiveMethods.removeFromComparison(carName);
            (context as Element).markNeedsBuild();
          } else {
            bool added = HiveMethods.addToComparison(car.toMap());
            if (added) {
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
          HiveMethods.isInComparison(car.itemName)
              ? Icons.compare_arrows_rounded
              : Icons.add_chart_rounded,
          color: HiveMethods.isInComparison(car.itemName)
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
