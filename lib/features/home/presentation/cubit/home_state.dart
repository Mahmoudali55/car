part of 'home_cubit.dart';

class HomeState extends Equatable {
  final StatusState carsModelsStatus;
  final StatusState brandCarsStatus;
  final StatusState<List<GetBrandCarsDataModel>> filteredCarsStatus;
  final StatusState<List<GetBrandCarsDataModel>> allCarsStatus;
  final StatusState allPopularCarsStatus;
  final int? selectedBrandId;
  final int selectedIndex;
  final List<CarModel> brands;
  final String searchQuery;
  final StatusState<AddBookingPermissionResponseModel> addBookingPermissionResponseModel;
  final String? brandId;
  final String? fromMakeYear;
  final String? toMakeYear;
  final int? fromPrice;
  final int? toPrice;
  final String? fuelType;
  const HomeState({
    this.carsModelsStatus = const StatusState.initial(),
    this.brandCarsStatus = const StatusState.initial(),
    this.filteredCarsStatus = const StatusState.initial(),
    this.allCarsStatus = const StatusState.initial(),
    this.allPopularCarsStatus = const StatusState.initial(),
    this.selectedBrandId,
    this.selectedIndex = 0,
    this.searchQuery = '',
    this.brands = const [],
    this.addBookingPermissionResponseModel = const StatusState.initial(),
    this.brandId,
    this.fromMakeYear,
    this.toMakeYear,
    this.fromPrice,
    this.toPrice,
    this.fuelType,
  });
  HomeState copyWith({
    StatusState? carsModelsStatus,
    StatusState? brandCarsStatus,
    StatusState<List<GetBrandCarsDataModel>>? filteredCarsStatus,
    StatusState<List<GetBrandCarsDataModel>>? allCarsStatus,
    StatusState? allPopularCarsStatus,
    int? selectedBrandId,
    int? selectedIndex,
    List<CarModel>? brands,
    String? searchQuery,
    StatusState<AddBookingPermissionResponseModel>? addBookingPermissionResponseModel,
    String? brandId,
    String? fromMakeYear,
    String? toMakeYear,
    int? fromPrice,
    int? toPrice,
    String? fuelType,
  }) {
    return HomeState(
      carsModelsStatus: carsModelsStatus ?? this.carsModelsStatus,
      brandCarsStatus: brandCarsStatus ?? this.brandCarsStatus,
      filteredCarsStatus: filteredCarsStatus ?? this.filteredCarsStatus,
      allCarsStatus: allCarsStatus ?? this.allCarsStatus,
      allPopularCarsStatus: allPopularCarsStatus ?? this.allPopularCarsStatus,
      selectedBrandId: selectedBrandId ?? this.selectedBrandId,
      selectedIndex: selectedIndex ?? this.selectedIndex,
      brands: brands ?? this.brands,
      searchQuery: searchQuery ?? this.searchQuery,
      addBookingPermissionResponseModel:
          addBookingPermissionResponseModel ?? this.addBookingPermissionResponseModel,
      brandId: brandId ?? this.brandId,
      fromMakeYear: fromMakeYear ?? this.fromMakeYear,
      toMakeYear: toMakeYear ?? this.toMakeYear,
      fromPrice: fromPrice ?? this.fromPrice,
      toPrice: toPrice ?? this.toPrice,
      fuelType: fuelType ?? this.fuelType,
    );
  }

  @override
  List<Object?> get props => [
    carsModelsStatus,
    brandCarsStatus,
    filteredCarsStatus,
    allCarsStatus,
    allPopularCarsStatus,
    selectedBrandId,
    selectedIndex,
    brands,
    searchQuery,
    addBookingPermissionResponseModel,
    brandId,
    fromMakeYear,
    toMakeYear,
    fromPrice,
    toPrice,
    fuelType,
  ];
}
