import 'package:car/core/network/status.state.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/data/model/offer_model.dart';
import 'package:equatable/equatable.dart' show Equatable;

class AgentState extends Equatable {
  @override
  final StatusState<List<CustomerModel>> customersStatus;
  final StatusState<List<OfferModel>> offersStatus;

  const AgentState({
    this.customersStatus = const StatusState.initial(),
    this.offersStatus = const StatusState.initial(),
  });

  AgentState copyWith({
    StatusState<List<CustomerModel>>? customersStatus,
    StatusState<List<OfferModel>>? offersStatus,
  }) {
    return AgentState(
      customersStatus: customersStatus ?? this.customersStatus,
      offersStatus: offersStatus ?? this.offersStatus,
    );
  }

  List<Object?> get props => [customersStatus, offersStatus];
}
