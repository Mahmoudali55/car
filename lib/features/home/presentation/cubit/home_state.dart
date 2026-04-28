part of 'home_cubit.dart';

class HomeState extends Equatable {
  final StatusState carsModelsStatus;
  final StatusState brandCarsStatus;
  final StatusState allPopularCarsStatus;
  final int? selectedBrandId;
  final int selectedIndex;
  final List<CarModel> brands;
  final String searchQuery;

  const HomeState({
    this.carsModelsStatus = const StatusState.initial(),
    this.brandCarsStatus = const StatusState.initial(),
    this.allPopularCarsStatus = const StatusState.initial(),
    this.selectedBrandId,
    this.selectedIndex = 0,

    this.searchQuery = '',
    this.brands = const [],
  });

  HomeState copyWith({
    StatusState? carsModelsStatus,
    StatusState? brandCarsStatus,
    StatusState? allPopularCarsStatus,
    int? selectedBrandId,
    int? selectedIndex,
    List<CarModel>? brands,
    String? searchQuery,
  }) {
    return HomeState(
      carsModelsStatus: carsModelsStatus ?? this.carsModelsStatus,
      brandCarsStatus: brandCarsStatus ?? this.brandCarsStatus,
      allPopularCarsStatus: allPopularCarsStatus ?? this.allPopularCarsStatus,
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      brands: brands ?? this.brands,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
    carsModelsStatus,
    brandCarsStatus,
    allPopularCarsStatus,
    selectedBrandId,
    selectedIndex,
    brands,
    searchQuery,
  ];
}
