part of 'home_cubit.dart';

class HomeState extends Equatable {
  final StatusState<List<CarModel>> carsModelsStatus;
  final StatusState<List<GetBrandCarsDataModel>> brandCarsStatus;
  final StatusState<Map<String, List<GetBrandCarsDataModel>>> allPopularCarsStatus;
  final int? selectedBrandId;

  const HomeState({
    this.carsModelsStatus = const StatusState.initial(),
    this.brandCarsStatus = const StatusState.initial(),
    this.allPopularCarsStatus = const StatusState.initial(),
    this.selectedBrandId,
  });

  HomeState copyWith({
    StatusState<List<CarModel>>? carsModelsStatus,
    StatusState<List<GetBrandCarsDataModel>>? brandCarsStatus,
    StatusState<Map<String, List<GetBrandCarsDataModel>>>? allPopularCarsStatus,
    int? selectedBrandId,
    bool clearSelectedBrand = false,
  }) {
    return HomeState(
      carsModelsStatus: carsModelsStatus ?? this.carsModelsStatus,
      brandCarsStatus: brandCarsStatus ?? this.brandCarsStatus,
      allPopularCarsStatus: allPopularCarsStatus ?? this.allPopularCarsStatus,
      selectedBrandId: clearSelectedBrand ? null : (selectedBrandId ?? this.selectedBrandId),
    );
  }

  @override
  List<Object?> get props => [
        carsModelsStatus,
        brandCarsStatus,
        allPopularCarsStatus,
        selectedBrandId,
      ];
}
