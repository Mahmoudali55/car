import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_shimmer_list.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/responsive_helper.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CategoriesWidget extends StatefulWidget {
  const CategoriesWidget({super.key});

  @override
  State<CategoriesWidget> createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCarsModels(); // ✅ fix
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet || context.isDesktop;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final status = state.carsModelsStatus;

        final bool isTablet = context.isTablet || context.isDesktop;

        // 🔄 Loading
        if (status.isLoading) {
          return SizedBox(
            height: isTablet ? 200.h : 140.h,
            child: CustomShimmerList(height: 100, width: 100),
          );
        }

        // ❌ Failure
        if (status.isFailure) {
          return SizedBox(
            height: isTablet ? 200.h : 140.h,
            child: Center(child: Text(status.error ?? 'Error')),
          );
        }

        // ✅ Success
        final brands = (status.data ?? []).take(5).toList();

        if (_selectedIndex >= brands.length) {
          _selectedIndex = 0;
        }

        return SizedBox(
          height: isTablet ? 200.h : 140.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            itemCount: brands.length,
            separatorBuilder: (_, __) => Gap(16.w),
            itemBuilder: (context, index) {
              final item = brands[index];
              final isSelected = _selectedIndex == index;

              return FadeInRight(
                delay: Duration(milliseconds: index * 50),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  child: AnimatedScale(
                    scale: isSelected ? 1.08 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      width: 90.w,
                      decoration: BoxDecoration(
                        gradient: isSelected
                            ? LinearGradient(
                                colors: [AppColor.primaryColor(context), const Color(0xff0047BB)],
                              )
                            : null,
                        color: isSelected ? null : AppColor.secondAppColor(context),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white.withOpacity(0.2)
                                  : AppColor.blackTextColor(context).withOpacity(0.03),
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              "${Constants.baseImage}${item.picturePath.replaceAll('../../Img/Emp/', '')}",
                              width: 32.w,
                              height: 32.w,
                              fit: BoxFit.contain,
                              color: isSelected ? Colors.white : null,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.directions_car_rounded,
                                color: isSelected ? Colors.white : AppColor.primaryColor(context),
                              ),
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            item.groupName ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.bodySmall(context).copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColor.blackTextColor(context).withOpacity(0.8),
                              fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
