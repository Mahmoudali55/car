import 'package:car/core/network/status.state.dart';
import 'package:car/features/agent/data/model/creat_offer_response_model.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/data/model/customer_profile_model.dart';
import 'package:car/features/agent/data/model/offer_model.dart';
import 'package:equatable/equatable.dart' show Equatable;

class AgentState extends Equatable {
  final StatusState<List<CustomerModel>> customersStatus;
  final StatusState<List<OfferModel>> offersStatus;
  final StatusState<CreatOfferResponseModel> createOfferStatus;
  final StatusState<CustomerProfileModel?> customerProfileStatus;
  final StatusState<OfferModel?> singleOfferStatus;

  const AgentState({
    this.customersStatus = const StatusState.initial(),
    this.offersStatus = const StatusState.initial(),
    this.createOfferStatus = const StatusState.initial(),
    this.customerProfileStatus = const StatusState.initial(),
    this.singleOfferStatus = const StatusState.initial(),
  });

  AgentState copyWith({
    StatusState<List<CustomerModel>>? customersStatus,
    StatusState<List<OfferModel>>? offersStatus,
    StatusState<CreatOfferResponseModel>? createOfferStatus,
    StatusState<CustomerProfileModel?>? customerProfileStatus,
    StatusState<OfferModel?>? singleOfferStatus,
  }) {
    return AgentState(
      customersStatus: customersStatus ?? this.customersStatus,
      offersStatus: offersStatus ?? this.offersStatus,
      createOfferStatus: createOfferStatus ?? this.createOfferStatus,
      customerProfileStatus: customerProfileStatus ?? this.customerProfileStatus,
      singleOfferStatus: singleOfferStatus ?? this.singleOfferStatus,
    );
  }

  @override
  List<Object?> get props => [
        customersStatus,
        offersStatus,
        createOfferStatus,
        customerProfileStatus,
        singleOfferStatus,
      ];
}
