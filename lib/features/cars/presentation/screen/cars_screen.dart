import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/cars/data/model/brand_model.dart';
import 'package:car/features/cars/presentation/screen/widget/car_search_header_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/cars_list_widget.dart';
import 'package:car/features/cars/presentation/screen/widget/section_header_widget.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CarsScreen extends StatefulWidget {
  const CarsScreen({super.key});

  @override
  State<CarsScreen> createState() => _CarsScreenState();
}

class _CarsScreenState extends State<CarsScreen> {
  BrandModel? _selectedBrand;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().fetchAllCars();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  GetBrandCarsDataModel _localizeCarData(GetBrandCarsDataModel car) {
    return car;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarSearchHeaderWidget(
          controller: _searchController,
          onChanged: (value) {
            setState(() {
              _searchQuery = value.trim().toLowerCase();
            });
          },
        ),
        Expanded(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state.allCarsStatus.isLoading) {
                return const Center(child: CustomLoading());
              } else if (state.allCarsStatus.isFailure) {
                return Center(
                  child: Text(
                    state.allCarsStatus.message ?? 'Error loading cars',
                    style: AppTextStyle.bodyMedium(
                      context,
                    ).copyWith(color: AppColor.redColor(context)),
                  ),
                );
              }

              final allAvailable = (state.allCarsStatus.data ?? [])
                  .where((car) => car.carStatus == 1)
                  .toList();

              // فلترة بالاسم لو فيه نص في خانة البحث
              final availableCars = _searchQuery.isEmpty
                  ? allAvailable
                  : allAvailable.where((car) {
                      final name = car.itemName.toLowerCase();
                      final brand = car.groupName.toLowerCase();
                      return name.contains(_searchQuery) || brand.contains(_searchQuery);
                    }).toList();

              return RefreshIndicator(
                onRefresh: () async {
                  _searchController.clear();
                  setState(() {
                    _searchQuery = '';
                  });
                  await Future.wait([
                    context.read<HomeCubit>().getCarsModels(),
                    context.read<HomeCubit>().fetchAllCars(),
                  ]);
                },
                color: AppColor.primaryColor(context),
                backgroundColor: AppColor.secondAppColor(context),
                child: ListView(
                  padding: EdgeInsets.zero,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  children: [
                    const SectionHeader(),
                    Gap(16.h),
                    CarsList(cars: availableCars, localizeCarData: _localizeCarData),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
