import 'package:car/core/network/status.state.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/admin/data/model/stock_statistics_model.dart';
import 'package:equatable/equatable.dart';

class AdminState extends Equatable {
  @override
  final StatusState<List<StockStatisticsModel>> getCarsCountStatus;
  final StatusState<CarsModel> getCarsStatus;

  const AdminState({
    this.getCarsCountStatus = const StatusState.initial(),
    this.getCarsStatus = const StatusState.initial(),
  });

  AdminState copyWith({
    StatusState<List<StockStatisticsModel>>? getCarsCountStatus,
    StatusState<CarsModel>? getCarsStatus,
  }) {
    return AdminState(
      getCarsCountStatus: getCarsCountStatus ?? this.getCarsCountStatus,
      getCarsStatus: getCarsStatus ?? this.getCarsStatus,
    );
  }

  List<Object?> get props => [getCarsCountStatus, getCarsStatus];
}
