import 'package:car/core/error/failures.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/agent/data/model/creat_offer_model.dart';
import 'package:car/features/agent/data/model/creat_offer_response_model.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:car/features/agent/data/model/offer_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class AgentRepo {
  Future<Either<Failure, List<CustomerModel>>> getCustomer(String? Searchval);
  Future<Either<Failure, List<OfferModel>>> getOffers(String? Searchval, int REPRESNO, int? LISTNO);
  Future<Either<Failure, CreatOfferResponseModel>> addbookingpermission(CreatOfferModel offer);
}

class AgentImplRepo implements AgentRepo {
  final ApiConsumer apiConsumer;

  AgentImplRepo(this.apiConsumer);
  @override
  Future<Either<Failure, List<CustomerModel>>> getCustomer(String? Searchval) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.customer,
          queryParameters: {'Searchval': Searchval, 'TableName': "sp_CUSTOMER_DATA_search_sel"},
        );
        return CustomerModel.listFromResponse(response['Data']);
      },
    );
  }

  @override
  Future<Either<Failure, List<OfferModel>>> getOffers(
    String? Searchval,
    int REPRESNO,
    int? LISTNO,
  ) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.getofferprice,
          queryParameters: {'Searchval': Searchval, 'REPRESNO': REPRESNO, 'LISTNO': LISTNO},
        );
        return OfferModel.listFromResponse(response['Data']);
      },
    );
  }

  @override
  Future<Either<Failure, CreatOfferResponseModel>> addbookingpermission(
    CreatOfferModel offer,
  ) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.post(
          EndPoints.addbookingpermission,
          body: offer.toJson(),
        );
        return CreatOfferResponseModel.fromJson(response);
      },
    );
  }
}
