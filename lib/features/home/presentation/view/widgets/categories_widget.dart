import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/network/status.state.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/custom_item_categories_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final status = state.carsModelsStatus;

        if (status.isLoading) {
          return const Center(child: CustomLoading());
        }

        if (status.isFailure) {
          return bulidCategriesFailure(status);
        }

        final brands = (status.data ?? []).take(5).toList();

        if (brands.isEmpty) {
          return bulidCategoriesEmpty(context);
        }

        return SizedBox(
          height: 140.h,
          width: double.infinity,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            physics: const BouncingScrollPhysics(),
            itemCount: brands.length,
            separatorBuilder: (_, __) => Gap(20.w),
            itemBuilder: (context, index) {
              final item = brands[index];
              final isSelected = state.selectedIndex == index;

              return FadeInRight(
                delay: Duration(milliseconds: index * 50),
                child: GestureDetector(
                  onTap: () {
                    context.read<HomeCubit>().selectBrand(index, item.groupCode.toString());
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

  SizedBox bulidCategoriesEmpty(BuildContext context) {
    return SizedBox(
      height: 140.h,
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
            Text(AppLocaleKey.agentNoCategoriesFound.tr(), style: AppTextStyle.bodyMedium(context)),
          ],
        ),
      ),
    );
  }

  SizedBox bulidCategriesFailure(StatusState<dynamic> status) {
    return SizedBox(
      height: 140.h,
      child: Center(child: Text(status.error ?? 'Error')),
    );
  }
}
