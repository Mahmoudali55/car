import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/navigator_methods.dart';
import 'package:car/features/favorites/presentation/view/cubit/favorites_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/spec_badge_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class MagazineCardWidget extends StatelessWidget {
  const MagazineCardWidget({super.key, required this.car});
  final Map<String, dynamic> car;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => NavigatorMethods.pushNamed(context, RoutesName.carDetailsScreen, arguments: car),
      child: Container(
        height: 380.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.secondAppColor(context),
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // 1. Background Typography (Faded Brand Name)
            Positioned(
              left: -20.w,
              top: 40.h,
              child: RotatedBox(
                quarterTurns: 3,
                child: Text(
                  car['brand'].toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.03),
                    fontSize: 80.sp,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 10,
                  ),
                ),
              ),
            ),

            // 2. Vertical Layout Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Action Bar inside Card
                Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                        decoration: BoxDecoration(
                          color: AppColor.primaryColor(context).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                            color: AppColor.primaryColor(context).withValues(alpha: 0.3),
                          ),
                        ),
                        child: Text(
                          car['brand'],
                          style: AppTextStyle.bodySmall(context).copyWith(
                            color: AppColor.primaryColor(context),
                            fontWeight: FontWeight.bold,
                            fontSize: 11.sp,
                          ),
                        ),
                      ),
                      BlocBuilder<FavoritesCubit, FavoritesState>(
                        builder: (context, state) {
                          final isFav = context.read<FavoritesCubit>().isFavorite(car['name']);
                          return GestureDetector(
                            onTap: () => context.read<FavoritesCubit>().toggleFavorite(car),
                            child: CircleAvatar(
                              radius: 18.r,
                              backgroundColor: Colors.black.withValues(alpha: 0.3),
                              child: Icon(
                                isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                                color: isFav ? Colors.redAccent : Colors.white,
                                size: 20.sp,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // 3. Featured Car Image (Floating effect)
                Expanded(
                  child: Center(
                    child: Transform.scale(
                      scale: 1.1,
                      child: Hero(
                        tag: 'popular_car_${car['name']}',
                        child: Image.asset(car['image'], fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),

                // 4. Glassmorphic Footer
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              car['name'],
                              style: AppTextStyle.titleMedium(context).copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 22.sp,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            car['price'],
                            style: AppTextStyle.titleMedium(context).copyWith(
                              color: AppColor.primaryColor(context),
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                            ),
                          ),
                        ],
                      ),
                      Gap(16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SpecBadgeWidget(icon: Icons.calendar_today_rounded, text: car['year']),
                          SpecBadgeWidget(icon: Icons.speed_rounded, text: car['mileage']),
                          SpecBadgeWidget(icon: Icons.electric_bolt_rounded, text: car['engine']),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
