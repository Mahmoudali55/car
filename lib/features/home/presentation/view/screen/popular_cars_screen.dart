import 'package:car/core/custom_widgets/custom_loading/custom_loading.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:car/features/home/presentation/view/widgets/app_header_popular_widget.dart';
import 'package:car/features/home/presentation/view/widgets/empty_state_widget.dart';
import 'package:car/features/home/presentation/view/widgets/magazine_card_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class PopularCarsScreen extends StatefulWidget {
  const PopularCarsScreen({super.key});

  @override
  State<PopularCarsScreen> createState() => _PopularCarsScreenState();
}

class _PopularCarsScreenState extends State<PopularCarsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getCarsModels();
    });
  }

  /// فلترة السيارات بناءً على البراند المختار
  Map<String, List<GetBrandCarsDataModel>> _filteredCarsMap(HomeState state) {
    final allCarsMap = Map<String, List<GetBrandCarsDataModel>>.from(
      state.allPopularCarsStatus.data ?? {},
    );

    if (state.selectedBrandId == null) return allCarsMap;

    final brands = state.carsModelsStatus.data ?? [];

    // Handle empty brands list
    if (brands.isEmpty) return {};

    // Find brand manually (firstOrNull not available in all Dart versions)
    CarModel? selectedBrand;
    for (final b in brands) {
      if (b.groupCode == state.selectedBrandId) {
        selectedBrand = b;
        break;
      }
    }

    // Handle brand not found
    if (selectedBrand == null) return {};

    final brandName = selectedBrand.groupName;
    return {brandName: allCarsMap[brandName] ?? []};
  }

  /// تحويل موديل السيارة إلى Map
  Map<String, dynamic> _carToMap(GetBrandCarsDataModel car) {
    String imageUrl(String path) =>
        '${Constants.baseImage}${path.replaceAll('../../Img/Emp/', '')}';

    return {
      'name': car.itemName,
      'groupCode': car.groupCode.toString(),
      'itemCode': car.itemCode.toString(),
      'chassisNo': car.chassisNo,
      'image': '${Constants.baseImage}${car.carImage}',
      'extraImages': car.extraImages.map(imageUrl).toList(),
      'brand': car.groupName,
      'price': '${car.price ?? "0"}',
      'year': car.makeYear.toString(),
      'mileage': '${car.kilometerReading ?? "0"} كم',
      'engine': '${car.cylinder} Cyl',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
      'carStatus': car.carStatus,
      'carStatusText': car.carStatusText,
      'CHASSIS_NO': car.chassisNo,
      'MOTOR_NO': car.motorNo,
      'KILOMETER_READING': car.kilometerReading,
      'CYLINDER': car.cylinder,
      'POWER_HOURSE': car.powerHourse,
      'FUEL_CAPACITY': car.fuelCapacity,
      'SEAT_NO': car.seatNo,
      'DOOR_NO': car.doorNo,
      'Color': car.color,
      'TRANSMISSION': car.transmission,
      'MAKE_YEAR': car.makeYear,
    };
  }

  bool _isCarsMapEmpty(Map<String, List<GetBrandCarsDataModel>> map) {
    return map.isEmpty || (map.length == 1 && map.values.first.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final status = state.allPopularCarsStatus;
        final isBrandSelected = state.selectedBrandId != null;
        final carsMap = _filteredCarsMap(state);
        final screenTitle = isBrandSelected && carsMap.isNotEmpty
            ? carsMap.keys.first
            : AppLocaleKey.popularCars.tr();

        return Scaffold(
          backgroundColor: AppColor.scaffoldColor(context),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: RefreshIndicator(
                onRefresh: () => context.read<HomeCubit>().getCarsModels(),
                color: AppColor.primaryColor(context),
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    AppHeader(title: screenTitle),
                    if (status.isLoading)
                      const SliverFillRemaining(child: Center(child: CustomLoading()))
                    else if (_isCarsMapEmpty(carsMap))
                      EmptyState(isBrandSelected: isBrandSelected)
                    else
                      ..._buildCarsSlivers(carsMap, isBrandSelected),
                    SliverToBoxAdapter(child: Gap(100.h)),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildCarsSlivers(
    Map<String, List<GetBrandCarsDataModel>> carsMap,
    bool isBrandSelected,
  ) {
    return carsMap.entries
        .where((e) => e.value.isNotEmpty)
        .expand(
          (entry) => [
            if (!isBrandSelected)
              SliverToBoxAdapter(
                child: BrandHeader(brandName: entry.key, count: entry.value.length),
              ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: isBrandSelected ? 20.h : 0),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 24.h),
                    child: MagazineCardWidget(car: _carToMap(entry.value[index])),
                  ),
                  childCount: entry.value.length,
                ),
              ),
            ),
          ],
        )
        .toList();
  }
}
