import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/responsive_helper.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/custom_item_categories_widget.dart';
import 'package:easy_localization/easy_localization.dart';
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
    context.read<HomeCubit>().getCarsModels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final status = state.carsModelsStatus;
        final bool isTablet = context.isTablet || context.isDesktop;
        if (status.isLoading) {
          return const Center(child: CustomLoading());
        }
        if (status.isFailure) {
          return SizedBox(
            height: isTablet ? 200.h : 140.h,
            child: Center(child: Text(status.error ?? 'Error')),
          );
        }
        final brands = (status.data ?? []).take(5).toList();
        if (cubit.selectedIndex >= brands.length) {
          cubit.selectedIndex = 0;
        }
        if (brands.isEmpty) {
          return SizedBox(
            height: isTablet ? 200.h : 140.h,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 40.sp,
                    color: AppColor.blackTextColor(context).withValues(alpha: .1),
                  ),
                  Gap(16.h),
                  Text(
                    AppLocaleKey.agentNoCategoriesFound.tr(),
                    style: AppTextStyle.bodyMedium(context),
                  ),
                ],
              ),
            ),
          );
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
              final isSelected = cubit.selectedIndex == index;

              return FadeInRight(
                delay: Duration(milliseconds: index * 50),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      cubit.selectedIndex = index;
                    });
                    cubit.getBrandCars(item.groupCode.toString());
                  },
                  child: CustomItemCategoriesWidget(isSelected: isSelected, item: item),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
