import 'package:car/core/network/status.state.dart';
import 'package:car/features/agent/data/model/creat_offer_response_model.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/data/model/offer_model.dart';
import 'package:equatable/equatable.dart' show Equatable;

class AgentState extends Equatable {
  final StatusState<List<CustomerModel>> customersStatus;
  final StatusState<List<OfferModel>> offersStatus;
  final StatusState<CreatOfferResponseModel> createOfferStatus;

  const AgentState({
    this.customersStatus = const StatusState.initial(),
    this.offersStatus = const StatusState.initial(),
    this.createOfferStatus = const StatusState.initial(),
  });

  AgentState copyWith({
    StatusState<List<CustomerModel>>? customersStatus,
    StatusState<List<OfferModel>>? offersStatus,
    StatusState<CreatOfferResponseModel>? createOfferStatus,
  }) {
    return AgentState(
      customersStatus: customersStatus ?? this.customersStatus,
      offersStatus: offersStatus ?? this.offersStatus,
      createOfferStatus: createOfferStatus ?? this.createOfferStatus,
    );
  }

  @override
  List<Object?> get props => [customersStatus, offersStatus, createOfferStatus];
}
