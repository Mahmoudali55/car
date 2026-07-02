import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:car/core/network/status.state.dart';
import 'package:car/features/home/data/model/add_booking_permission_model.dart';
import 'package:car/features/home/data/model/add_booking_permission_response_model.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_response_model.dart';
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

        if (fetchedBrands.isNotEmpty) {
          if (state.selectedBrandId == null) {
            selectBrand(0, fetchedBrands.first.groupCode.toString());
          } else if (state.selectedIndex >= fetchedBrands.length) {
            selectBrand(0, fetchedBrands.first.groupCode.toString());
          }

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
        allCarsMap[brandName] = carsList;
      });
    }

    emit(state.copyWith(allPopularCarsStatus: StatusState.success(allCarsMap)));
  }

  Future<void> getBrandCars(String brandId) async {
    if (brandId == 'null' || brandId.isEmpty) {
      emit(state.copyWith(brandCarsStatus: const StatusState.success([]), selectedBrandId: null));
      return;
    }
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

  Future<void> fetchAllCars({
    int? brandId,
    String? fromMakeYear,
    String? toMakeYear,
    int? fromPrice,
    int? toPrice,
    String? fuelType,
  }) async {
    emit(
      state.copyWith(
        allCarsStatus: const StatusState.loading(),
        brandId: brandId,
        fromMakeYear: fromMakeYear,
        toMakeYear: toMakeYear,
        fromPrice: fromPrice,
        toPrice: toPrice,
        fuelType: fuelType,
      ),
    );
    final result = await homeRepo.fetchAllCars(
      brandId,
      fromMakeYear,
      toMakeYear,
      fromPrice,
      toPrice,
      fuelType,
    );
    result.fold(
      (failure) {
        emit(state.copyWith(allCarsStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(allCarsStatus: StatusState.success(response)));
      },
    );
  }

  void selectBrand(int index, String brandId) {
    emit(state.copyWith(selectedIndex: index, selectedBrandId: int.tryParse(brandId)));
    unawaited(getBrandCars(brandId));
  }

  List<CarModel> getFilteredBrands(List<CarModel> brands, String query) {
    if (query.isEmpty) return brands;
    return brands.where((b) => b.groupName.toLowerCase().contains(query.toLowerCase())).toList();
  }

  void updateSearchQuery(String value) {
    emit(state.copyWith(searchQuery: value));
  }

  Future<void> getAddBookingPermission(AddBookingPermissionModel model) async {
    emit(state.copyWith(addBookingPermissionResponseModel: const StatusState.loading()));
    final result = await homeRepo.addBookingPermission(model);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            addBookingPermissionResponseModel: StatusState.failure(failure.errMessage),
          ),
        );
      },
      (response) {
        emit(state.copyWith(addBookingPermissionResponseModel: StatusState.success(response)));
      },
    );
  }

  Future<void> cancelReservedCar(CancelReservedCarModel model) async {
    emit(state.copyWith(cancelReservedCarResponseModel: const StatusState.loading()));
    final result = await homeRepo.cancelreservedcar(model);
    result.fold(
      (failure) {
        emit(
          state.copyWith(cancelReservedCarResponseModel: StatusState.failure(failure.errMessage)),
        );
      },
      (response) {
        emit(state.copyWith(cancelReservedCarResponseModel: StatusState.success(response)));
      },
    );
  }
}
