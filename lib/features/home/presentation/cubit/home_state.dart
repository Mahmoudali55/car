part of 'home_cubit.dart';

class HomeState extends Equatable {
  final StatusState<List<CarModel>> carsModelsStatus;

  const HomeState({this.carsModelsStatus = const StatusState.initial()});

  HomeState copyWith({StatusState<List<CarModel>>? carsModelsStatus}) {
    return HomeState(carsModelsStatus: carsModelsStatus ?? this.carsModelsStatus);
  }

  @override
  List<Object?> get props => [carsModelsStatus];
}
