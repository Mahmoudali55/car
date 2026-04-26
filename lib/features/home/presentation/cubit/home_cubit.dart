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

  List<CarModel> brands = [];

  Future<void> getCarsModels() async {
    emit(state.copyWith(carsModelsStatus: const StatusState.loading()));

    final result = await homeRepo.getCarsModels();

    result.fold(
      (failure) {
        emit(state.copyWith(carsModelsStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        dynamic data = response.cars;

        // لو String → decode
        if (data is String) {
          data = jsonDecode(data);
        }

        // لو already List<CarModel>
        if (data is List<CarModel>) {
          brands = data;
        }
        // لو List<Map>
        else if (data is List) {
          brands = data.map((e) {
            if (e is CarModel) return e;
            return CarModel.fromJson(e);
          }).toList();
        }

        emit(state.copyWith(carsModelsStatus: StatusState.success(brands)));

        if (brands.isNotEmpty) {
          fetchAllBrandsCars();
        }
      },
    );
  }

  Future<void> fetchAllBrandsCars() async {
    if (state.allPopularCarsStatus.isLoading) return;
    emit(state.copyWith(allPopularCarsStatus: const StatusState.loading()));

    final Map<String, List<GetBrandCarsDataModel>> allCarsMap = {};
    
    // Fetch cars for each brand (limiting to first 12 brands for performance)
    final brandsToFetch = brands.take(12).toList();
    
    final List<Future> futures = [];
    for (var brand in brandsToFetch) {
      futures.add(homeRepo.getBrandCars(brand.groupCode.toString()));
    }

    final results = await Future.wait(futures);

    for (int i = 0; i < results.length; i++) {
      final result = results[i];
      final brandName = brandsToFetch[i].groupName;

      result.fold(
        (failure) => null,
        (carsList) {
          if (carsList is List<GetBrandCarsDataModel>) {
            allCarsMap[brandName] = carsList;
          }
        },
      );
    }

    emit(state.copyWith(allPopularCarsStatus: StatusState.success(allCarsMap)));
  }

  Future<void> getBrandCars(String brandId) async {
    emit(state.copyWith(
      brandCarsStatus: const StatusState.loading(),
      selectedBrandId: int.tryParse(brandId),
    ));
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
}
