import 'package:car/core/network/status.state.dart';
import 'package:car/features/admin/data/model/stock_statistics_model.dart';
import 'package:equatable/equatable.dart';

class AdminState extends Equatable {
  @override
  final StatusState<List<StockStatisticsModel>> getCarsCountStatus;

  const AdminState({this.getCarsCountStatus = const StatusState.initial()});

  AdminState copyWith({StatusState<List<StockStatisticsModel>>? getCarsCountStatus}) {
    return AdminState(getCarsCountStatus: getCarsCountStatus ?? this.getCarsCountStatus);
  }

  List<Object?> get props => [getCarsCountStatus];
}
