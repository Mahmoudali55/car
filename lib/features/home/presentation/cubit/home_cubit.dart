import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:car/core/network/status.state.dart';
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
      },
    );
  }
}
