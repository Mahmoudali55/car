import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/responsive_helper.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/custom_item_brand_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class AllBrandsScreen extends StatefulWidget {
  const AllBrandsScreen({super.key});

  @override
  State<AllBrandsScreen> createState() => _AllBrandsScreenState();
}

class _AllBrandsScreenState extends State<AllBrandsScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().getCarsModels();
  }

  List<CarModel> _getFilteredBrands(List<CarModel> brands) {
    if (_searchQuery.isEmpty) return brands;

    return brands
        .where((b) => b.groupName.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final bool isTablet = context.isTablet || context.isDesktop;
    return Scaffold(
      appBar: CustomAppBar(
        context,
        centerTitle: false,
        automaticallyImplyLeading: true,
        title: Text(AppLocaleKey.allBrands.tr(), style: AppTextStyle.titleMedium(context)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                  child: CustomFormField(
                    radius: 16.r,
                    onChanged: (val) => setState(() => _searchQuery = val),
                    prefixIcon: const Icon(Icons.search),
                    hintText: AppLocaleKey.searchForBrand.tr(),
                  ),
                ),
                // Brands grid
                Expanded(
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      final cubit = context.read<HomeCubit>();

                      if (state.carsModelsStatus.isLoading) {
                        return const Center(child: CustomLoading());
                      }

                      if (state.carsModelsStatus.isFailure) {
                        return Center(
                          child: Text(
                            state.carsModelsStatus.message ?? '',
                            style: AppTextStyle.bodyMedium(context),
                          ),
                        );
                      }

                      final brands = _getFilteredBrands(cubit.brands);

                      if (brands.isEmpty) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.car_rental_rounded, size: 60.w, color: Colors.grey),
                            Gap(12.h),
                            Text(
                              AppLocaleKey.agentNoBrandsAvailable.tr(),
                              style: AppTextStyle.bodyMedium(context),
                            ),
                          ],
                        );
                      }

                      return GridView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                        physics: const BouncingScrollPhysics(),
                        itemCount: brands.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isTablet ? 6 : 3,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 0.85,
                        ),
                        itemBuilder: (context, index) {
                          final brand = brands[index];

                          return CustomItemBrandWidget(brand: brand);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
