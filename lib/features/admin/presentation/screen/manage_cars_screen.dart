import 'package:animate_do/animate_do.dart';
import 'package:car/core/custom_widgets/custom_app_bar/custom_app_bar.dart';
import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/routes/routes_name.dart';
import 'package:car/core/theme/app_colors.dart';
import 'package:car/core/theme/app_text_style.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/admin/data/model/stock_statistics_model.dart';
import 'package:car/features/admin/presentation/cubit/admin_cubit.dart';
import 'package:car/features/admin/presentation/cubit/admin_state.dart';
import 'package:car/features/admin/presentation/screen/car_quotation_preview_screen.dart';
import 'package:car/features/admin/presentation/screen/widgets/car_filter_chips.dart';
import 'package:car/features/admin/presentation/screen/widgets/car_inventory_card.dart';
import 'package:car/features/admin/presentation/screen/widgets/fleet_stats_row.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/presentation/cubit/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import 'widgets/empty_state_widget.dart';

class ManageCarsScreen extends StatefulWidget {
  const ManageCarsScreen({super.key});

  @override
  State<ManageCarsScreen> createState() => _ManageCarsScreenState();
}

class _ManageCarsScreenState extends State<ManageCarsScreen> {
  String _selectedFilter = 'available';
  static const Map<String, int> _filterToStatus = {
    'available': 1,
    'reserved': 2,
    'sold': 3,
    'returned': 4,
  };

  @override
  void initState() {
    super.initState();
    context.read<AdminCubit>().getCarsStatus(_filterToStatus['available']!);
    context.read<AdminCubit>().getCarsCountStatus();
    final homeCubit = context.read<HomeCubit>();
    if (homeCubit.state.brands.isEmpty) {
      homeCubit.getCarsModels();
    }
    if (homeCubit.state.allCarsStatus.data == null || homeCubit.state.allCarsStatus.data!.isEmpty) {
      homeCubit.fetchAllCars();
    }
  }

  void _onFilterChanged(String filter) {
    if (_selectedFilter == filter) return;
    setState(() => _selectedFilter = filter);
    context.read<AdminCubit>().getCarsStatus(_filterToStatus[filter]!);
  }

  String _statusKey(int? carStatus) {
    switch (carStatus) {
      case 1:
        return 'available';
      case 2:
        return 'reserved';
      case 3:
        return 'sold';
      case 4:
        return 'returned';
      default:
        return 'available';
    }
  }

  Map<String, String> _toMap(CarModel car) {
    return {
      'name': car.itemName ?? car.itemCode ?? '—',
      'status': _statusKey(car.carStatus),
      'price': car.costPrice != null ? car.costPrice!.toStringAsFixed(0) : '—',
      'year': car.makeYear?.toString() ?? '—',
      'mileage': car.chassisNo ?? '—',
      'image': '',
      'bank': car.storeCode ?? '—',
    };
  }

  void _showPrintDialog(Map<String, String> car) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => CarQuotationPreviewScreen(car: car)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldColor(context),
      appBar: CustomAppBar(
        context,
        appBarColor: AppColor.scaffoldColor(context),
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: null,
        centerTitle: true,
        title: Text(
          AppLocaleKey.fleetManagement.tr(),
          style: AppTextStyle.titleMedium(
            context,
          ).copyWith(fontWeight: FontWeight.w900, fontSize: 20.sp),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, RoutesName.addCar),
            icon: Container(
              padding: EdgeInsets.all(6.w),
              decoration: BoxDecoration(
                color: AppColor.primaryColor(context).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Icon(Icons.add_rounded, color: AppColor.primaryColor(context), size: 20.sp),
              ),
            ),
          ),
          Gap(10.w),
        ],
      ),
      body: BlocBuilder<AdminCubit, AdminState>(
        builder: (context, state) {
          final carsStatus = state.getCarsStatus;
          final countStatus = state.getCarsCountStatus;
          final StockStatisticsModel? stats =
              countStatus.isSuccess && countStatus.data != null && countStatus.data!.isNotEmpty
              ? countStatus.data!.first
              : null;
          final List<Map<String, String>> cars = carsStatus.isSuccess && carsStatus.data != null
              ? carsStatus.data!.data.map(_toMap).toList()
              : [];
          return Column(
            children: [
              FleetStatsRow(stats: stats),
              Gap(14.h),
              CarFilterChips(selectedFilter: _selectedFilter, onFilterChanged: _onFilterChanged),
              Gap(4.h),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child: carsStatus.isLoading
                      ? const Center(key: ValueKey('loading'), child: CircularProgressIndicator())
                      : carsStatus.isFailure
                      ? Center(
                          key: const ValueKey('error'),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.error_outline_rounded,
                                size: 48.sp,
                                color: AppColor.redColor(context),
                              ),
                              Gap(12.h),
                              Text(
                                carsStatus.error ?? 'حدث خطأ ما',
                                style: AppTextStyle.bodyMedium(context),
                                textAlign: TextAlign.center,
                              ),
                              Gap(16.h),
                              TextButton(
                                onPressed: () => context.read<AdminCubit>().getCarsStatus(
                                  _filterToStatus[_selectedFilter]!,
                                ),
                                child: const Text('إعادة المحاولة'),
                              ),
                            ],
                          ),
                        )
                      : cars.isEmpty
                      ? const EmptyState(key: ValueKey('empty'))
                      : ListView.separated(
                          key: ValueKey(_selectedFilter),
                          padding: EdgeInsets.all(16.w),
                          physics: const BouncingScrollPhysics(),
                          itemCount: cars.length,
                          separatorBuilder: (_, __) => Gap(10.h),
                          itemBuilder: (context, i) {
                            final carMap = cars[i];
                            final originalCar = carsStatus.data!.data[i];
                            return FadeInUp(
                              delay: Duration(milliseconds: i * 40),
                              duration: const Duration(milliseconds: 300),
                              child: GestureDetector(
                                onTap: () {
                                  final homeCubit = context.read<HomeCubit>();
                                  final allHomeCars = homeCubit.state.allCarsStatus.data ?? [];
                                  GetBrandCarsDataModel? brandCar;
                                  for (final c in allHomeCars) {
                                    if (c.itemCode == originalCar.itemCode) {
                                      brandCar = c;
                                      break;
                                    }
                                  }

                                  if (brandCar == null) {
                                    final brandList = homeCubit.state.brands;
                                    String brandName = '';
                                    for (final b in brandList) {
                                      if (b.groupCode == originalCar.groupCode) {
                                        brandName = b.groupName;
                                        break;
                                      }
                                    }
                                    brandCar = GetBrandCarsDataModel(
                                      groupCode: originalCar.groupCode ?? 0,
                                      groupName: brandName,
                                      grName: brandName.isNotEmpty
                                          ? "$brandName - ${originalCar.itemName ?? ''}"
                                          : (originalCar.itemName ?? ''),
                                      groupParent: 0,
                                      groupLevel: 0,
                                      price: originalCar.costPrice?.toStringAsFixed(0),
                                      itemCode: originalCar.itemCode ?? '',
                                      itemType: originalCar.carType ?? 0,
                                      itemName: originalCar.itemName ?? '',
                                      groupCode1: originalCar.groupCode ?? 0,
                                      storeCode: originalCar.storeCode ?? '',
                                      carStatus: originalCar.carStatus ?? 0,
                                      carType: originalCar.carType ?? 0,
                                      chassisNo: originalCar.chassisNo ?? '',
                                      bodyColor: originalCar.bodyColor ?? '',
                                      transmission: originalCar.transmission ?? 0,
                                      cylinder: '',
                                      powerHourse: '',
                                      fuelCapacity: '',
                                      fuelType: originalCar.fuelType ?? '',
                                      seatNo: 0,
                                      doorNo: 0,
                                      addType: 0,
                                      colorCode: originalCar.colorCode ?? 0,
                                      makeYear: originalCar.makeYear ?? 0,
                                      notifyType: 0,
                                      supplierCd: 0,
                                      buyDate: '',
                                      trNo: 0,
                                      reasonId: 0,
                                      mobileShow: originalCar.mobileShow ?? false,
                                      carImage: '',
                                      color: originalCar.bodyColor ?? '',
                                    );
                                  }
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.carDetailsScreen,
                                    arguments: {
                                      'car': brandCar,
                                      'heroTag': 'admin_car_image_${brandCar.itemCode}',
                                      'isFromAdmin': true,
                                    },
                                  );
                                },
                                child: CarInventoryCard(
                                  car: carMap,
                                  onEdit: () {},
                                  onWhatsApp: () {},
                                  onDelete: () {},
                                  onPrint: () => _showPrintDialog(carMap),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
