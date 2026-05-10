import 'package:car/core/custom_widgets/custom_image/custom_network_image.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/offers/presentation/screen/widget/mini_spec_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CustomItemOfferWidget extends StatelessWidget {
  const CustomItemOfferWidget({super.key, required this.offer});

  final Map<String, dynamic> offer;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Car Image with Gradient Background
        Expanded(
          flex: 4,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              bottomLeft: Radius.circular(16.r),
            ),
            child: Hero(
              tag: 'car_offer_${offer['name']}',
              child: Center(
                child: offer['image'].toString().startsWith('http')
                  ? CustomNetworkImage(
                      imageUrl: offer['image'] as String,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : Image.asset(offer['image'], fit: BoxFit.fill, height: double.infinity),
              ),
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
                        final isFav = context.read<FavoritesCubit>().isFavorite(offer['name']);
                        return GestureDetector(
                          onTap: () => context.read<FavoritesCubit>().toggleFavorite(offer),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Icon(
                              isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                              color: isFav
                                  ? AppColor.redColor(context)
                                  : AppColor.blackTextColor(context).withValues(alpha: 0.24),
                              size: 20.sp,
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                Gap(6.h),
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
                  style: AppTextStyle.titleMedium(
                    context,
                  ).copyWith(color: AppColor.blackTextColor(context), fontWeight: FontWeight.w900),
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

                Row(
                  children: [
                    MiniSpecWidget(
                      icon: Icons.calendar_today_rounded,
                      value: offer['year'] ?? '2024',
                    ),
                    Gap(12.w),
                    MiniSpecWidget(
                      icon: Icons.settings_input_component_rounded,
                      value: offer['engine'] ?? 'V8',
                    ),
                  ],
                ),
                Gap(10.h),
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
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
