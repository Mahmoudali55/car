import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/custom_widgets/custom_form_field/custom_form_field.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/core/utils/responsive_helper.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AllBrandsScreen extends StatefulWidget {
  final bool isFromMainLayout;
  const AllBrandsScreen({super.key, this.isFromMainLayout = false});

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
      appBar: widget.isFromMainLayout
          ? null
          : CustomAppBar(
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
                // Search bar
                if (!widget.isFromMainLayout)
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
                        return const Center(child: CircularProgressIndicator());
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
                        return const Center(child: Text("No brands found"));
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

                          return GestureDetector(
                            onTap: () {
                              // Navigator.pushNamed(
                              //   context,
                              //   RoutesName.brandCarsScreen,
                              //   arguments: {'name': brand.groupName, 'id': brand.groupCode},
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                borderRadius: BorderRadius.circular(16.r),
                                border: Border.all(color: Colors.grey.withOpacity(0.15)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  // Image
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(12.w),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.05),
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12.r),
                                          child: Image.network(
                                            "https://delta-asg.com:54510/MyVirtualDir/${brand.picturePath.replaceAll('../../Img/Emp/', '')}",
                                            fit: BoxFit.contain,
                                            width: double.infinity,
                                            errorBuilder: (_, __, ___) => Icon(
                                              Icons.directions_car_rounded,
                                              size: 30.w,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Name
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(8.w, 0, 8.w, 10.h),
                                    child: Text(
                                      brand.groupName,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyle.bodyMedium(
                                        context,
                                      ).copyWith(fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
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
