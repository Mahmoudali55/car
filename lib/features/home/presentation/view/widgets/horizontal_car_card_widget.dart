import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      onTap: onTap,
      child: Container(
        width: 220.w,
        margin: EdgeInsets.only(right: 16.w),
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: AppColor.blackTextColor(context).withOpacity(0.05),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [   
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                  child: Container(
                    color: AppColor.blackTextColor(context).withOpacity(0.02),
                    height: 120.h,
                    width: double.infinity,
                    child: Hero(
                      tag: 'budget_car_${car['name']}_${car['cashPrice']}',
                      child: Image.asset(
                        car['image'] ?? 'assets/images/cars/mercedes-benz.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 8.h,
                  right: 8.w,
                  child:  BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = context
                              .read<FavoritesCubit>()
                              .isFavorite(car['name']);
                          return GestureDetector(
                            onTap: () => context
                                .read<FavoritesCubit>()
                                .toggleFavorite(car),
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Colors.black.withValues(
                                alpha: 0.3,
                              ),
                              child: Icon(
                                isFav
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: isFav ? Colors.redAccent : AppColor.blackTextColor(context),
                                size: 20.sp,
                              ),
                            ),
                          );
                        },
                      ),
                )
              ]
            ),
               Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Text(
                            car['name'] ?? 'Car Name',
                            style: AppTextStyle.titleSmall(context).copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
               ),
            // Details Section
            Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                     
                      decoration: BoxDecoration(
                        color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'سعر الكاش',
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: AppColor.greyColor(context),
                              fontSize: 10.sp,
                            ),
                        ),
                        Gap(4.h),
                      Text(
                        car['cashPrice'] ?? '',
                        style: AppTextStyle.bodySmall(context).copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColor.primaryColor(context),
                        ),
                      ),
                        ],
                      ),
                    ),
                  ),
                  Gap(4.h),
                  Divider(
                    color: AppColor.greyColor(context).withValues(alpha: 0.2),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          'القسط الشهري',
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColor.greyColor(context),
                            fontSize: 10.sp,
                          ),
                        ),
                        Gap(4.h),
                        Text(
                         car['installmentPrice'] ,
                          style: AppTextStyle.bodySmall(context).copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.greenAccent,
                          ),),
                         if (car['isTamaraAvailable'] == true) ...[
                      Gap(20.h),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Image.asset(
                          height: 20.h,
                          'assets/global_icon/images.jpeg',
                        ),
                      ),
                    ],
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
