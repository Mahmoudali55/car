import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:car/core/network/status.state.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:car/features/home/data/repository/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;

  HomeCubit(this.homeRepo) : super(const HomeState());

  Future<void> getCarsModels() async {
    emit(state.copyWith(carsModelsStatus: const StatusState.loading()));

    final result = await homeRepo.getCarsModels();

    result.fold(
      (failure) {
        emit(state.copyWith(carsModelsStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        dynamic data = response.cars;

        if (data is String) {
          data = jsonDecode(data);
        }

        List<CarModel> fetchedBrands = [];

        if (data is List<CarModel>) {
          fetchedBrands = data;
        } else if (data is List) {
          fetchedBrands = data.map((e) {
            if (e is CarModel) return e;
            return CarModel.fromJson(e);
          }).toList();
        }

        emit(
          state.copyWith(
            carsModelsStatus: StatusState.success(fetchedBrands),
            brands: fetchedBrands,
          ),
        );
        if (state.selectedIndex >= fetchedBrands.length) {
          emit(state.copyWith(selectedIndex: 0));
        }

        if (fetchedBrands.isNotEmpty) {
          fetchAllBrandsCars(fetchedBrands);
        }
      },
    );
  }

  Future<void> fetchAllBrandsCars(List<CarModel> brands) async {
    if (state.allPopularCarsStatus.isLoading) return;

    emit(state.copyWith(allPopularCarsStatus: const StatusState.loading()));

    final Map<String, List<GetBrandCarsDataModel>> allCarsMap = {};

    final brandsToFetch = brands.take(12).toList();

    final results = await Future.wait(
      brandsToFetch.map((b) => homeRepo.getBrandCars(b.groupCode.toString())),
    );

    for (int i = 0; i < results.length; i++) {
      final result = results[i];
      final brandName = brandsToFetch[i].groupName;

      result.fold((_) {}, (carsList) {
        if (carsList is List<GetBrandCarsDataModel>) {
          allCarsMap[brandName] = carsList;
        }
      });
    }

    emit(state.copyWith(allPopularCarsStatus: StatusState.success(allCarsMap)));
  }

  Future<void> getBrandCars(String brandId) async {
    emit(
      state.copyWith(
        brandCarsStatus: const StatusState.loading(),
        selectedBrandId: int.tryParse(brandId),
      ),
    );

    final result = await homeRepo.getBrandCars(brandId);

    result.fold(
      (failure) {
        emit(state.copyWith(brandCarsStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(brandCarsStatus: StatusState.success(response)));
      },
    );
  }

  void selectBrand(int index, String brandId) {
    emit(state.copyWith(selectedIndex: index, selectedBrandId: int.tryParse(brandId)));

    // بدون await عشان الأداء
    unawaited(getBrandCars(brandId));
  }

  List<CarModel> getFilteredBrands(List<CarModel> brands, String query) {
    if (query.isEmpty) return brands;

    return brands.where((b) => b.groupName.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void updateSearchQuery(String value) {
    emit(state.copyWith(searchQuery: value));
  }
}
