import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesState>(
      builder: (context, state) {
        if (state is FavoritesLoaded) {
          if (state.favorites.isEmpty) {
            return _buildEmptyState(context);
          }
          return _buildFavoritesList(context, state.favorites);
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(32.w),
            decoration: BoxDecoration(
              color: AppColor.secondAppColor(context),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                width: 2,
              ),
            ),
            child: Icon(
              Icons.favorite_border_rounded,
              size: 80.sp,
              color: AppColor.greyColor(context).withValues(alpha: 0.2),
            ),
          ),
          Gap(24.h),
          Text(
            AppLocaleKey.noFavoritesYet.tr(),
            style: AppTextStyle.titleMedium(
              context,
            ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Gap(8.h),
          Text(
            AppLocaleKey.addCarsToFavorites.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyle.bodySmall(context).copyWith(color: AppColor.greyColor(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList(BuildContext context, List<Map<String, dynamic>> favorites) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 100.h),
      itemCount: favorites.length,
      separatorBuilder: (context, index) => Gap(16.h),
      itemBuilder: (context, index) {
        final car = favorites[index];
        return _buildFavoriteItem(context, car);
      },
    );
  }

  Widget _buildFavoriteItem(BuildContext context, Map<String, dynamic> car) {
    return GestureDetector(
      onTap: () {
        NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car);
      },
      child: Container(
        height: 120.h,
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          children: [
            // Image Section
            Container(
              width: 120.w,
              padding: EdgeInsets.all(12.w),
              color: Colors.white.withValues(alpha: 0.05),
              child: Hero(
                tag: 'car_image_${car['name']}',
                child: Image.asset(car['image'], fit: BoxFit.contain),
              ),
            ),

            // Info Section
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      car['brand'],
                      style: AppTextStyle.bodySmall(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      car['name'],
                      style: AppTextStyle.bodyMedium(
                        context,
                      ).copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Gap(8.h),
                    Text(
                      car['price'],
                      style: AppTextStyle.bodyMedium(context).copyWith(
                        color: AppColor.primaryColor(context),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Remove Button
            IconButton(
              onPressed: () {
                context.read<FavoritesCubit>().toggleFavorite(car);
              },
              icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent),
            ),
            Gap(8.w),
          ],
        ),
      ),
    );
  }
}
