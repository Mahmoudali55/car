import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PremiumOfferCardWidget extends StatelessWidget {
  const PremiumOfferCardWidget({super.key, required this.offer});
  final Map<String, dynamic> offer;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: offer),
      child: Container(
        height: 220.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 0.h), // Slightly increased for specs
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: AppColor.blackTextColor(context).withValues(alpha: 0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
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
                  style: TextStyle(
                    color: AppColor.blackTextColor(context),
                    fontSize: 50.sp,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            Row(
              children: [
                // Car Image with Gradient Background
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: const BoxDecoration(),
                    padding: EdgeInsets.all(12.w),
                    child: Hero(
                      tag: 'car_offer_${offer['name']}',
                      child: Center(child: Image.asset(offer['image'], fit: BoxFit.contain)),
                    ),
                  ),
                ),

                // Details
                Expanded(
                  flex: 6,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 14.h, 20.w, 14.h), // Reduced vertical padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                offer['category'],
                                style: TextStyle(
                                  color: AppColor.primaryColor(context),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            BlocBuilder<FavoritesCubit, FavoritesState>(
                              builder: (context, state) {
                                final isFav = context.read<FavoritesCubit>().isFavorite(
                                  offer['name'],
                                );
                                return GestureDetector(
                                  onTap: () => context.read<FavoritesCubit>().toggleFavorite(offer),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Icon(
                                      isFav
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_outline_rounded,
                                      color: isFav
                                          ? Colors.redAccent
                                          : AppColor.blackTextColor(
                                              context,
                                            ).withValues(alpha: 0.24),
                                      size: 20.sp, // Slightly reduced icon
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Gap(6.h), // Reduced gap from 8
                        Text(
                          offer['brand'] ?? '',
                          style: TextStyle(
                            color: AppColor.primaryColor(context),
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          offer['name'],
                          style: AppTextStyle.titleMedium(context).copyWith(
                            color: AppColor.blackTextColor(context),
                            fontWeight: FontWeight.w900,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Gap(4.h),
                        Row(
                          children: [
                            Icon(Icons.timer_outlined, color: Colors.orangeAccent, size: 12.sp),
                            Gap(4.w),
                            Text(
                              offer['expiresIn'],
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        // Specs Row
                        Row(
                          children: [
                            _buildMiniSpec(
                              Icons.calendar_today_rounded,
                              offer['year'] ?? '2024',
                              context,
                            ),
                            Gap(12.w),
                            _buildMiniSpec(
                              Icons.settings_input_component_rounded,
                              offer['engine'] ?? 'V8',
                              context,
                            ),
                          ],
                        ),
                        Gap(10.h), // Reduced gap from 12
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    offer['oldPrice'],
                                    style: TextStyle(
                                      color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
                                      fontSize: 11.sp,
                                      decoration: TextDecoration.lineThrough,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    offer['price'],
                                    style: AppTextStyle.titleSmall(context).copyWith(
                                      color: AppColor.blackTextColor(context),
                                      fontWeight: FontWeight.w900,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Gap(4.w),
                            Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: AppColor.primaryColor(context),
                                borderRadius: BorderRadius.circular(12.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: AppColor.whiteColor(context),
                                size: 16.sp,
                              ),
                            ),
                          ],
                        ),
                        Gap(18.h),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Discount Badge - Hanging Tag Design
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
                      style: TextStyle(
                        color: AppColor.whiteColor(context),
                        fontWeight: FontWeight.w900,
                        fontSize: 14.sp,
                      ),
                    ),
                    Text(
                      'OFF',
                      style: TextStyle(
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

  Widget _buildMiniSpec(IconData icon, String value, BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColor.blackTextColor(context).withValues(alpha: 0.24), size: 13.sp),
        Gap(4.w),
        Text(
          value,
          style: TextStyle(
            color: AppColor.blackTextColor(context).withValues(alpha: 0.38),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
