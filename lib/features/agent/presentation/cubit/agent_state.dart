import 'package:car/core/network/status.state.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:equatable/equatable.dart' show Equatable;

class AgentState extends Equatable {
  @override
  final StatusState<List<CustomerModel>> customersStatus;

  const AgentState({this.customersStatus = const StatusState.initial()});

  AgentState copyWith({StatusState<List<CustomerModel>>? customersStatus}) {
    return AgentState(customersStatus: customersStatus ?? this.customersStatus);
  }

  List<Object?> get props => [customersStatus];
}
