import 'package:car/core/error/failures.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/agent/data/model/customer_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class AgentRepo {
  Future<Either<Failure, List<CustomerModel>>> getCustomer(String? Searchval);
}

class AgentImplRepo implements AgentRepo {
  final ApiConsumer apiConsumer;

  AgentImplRepo(this.apiConsumer);
  @override
  Future<Either<Failure, List<CustomerModel>>> getCustomer(String? Searchval) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.Customer,
          queryParameters: {'Searchval': Searchval, 'TableName': "sp_CUSTOMER_DATA_search_sel"},
        );
        return CustomerModel.listFromResponse(response['Data']);
      },
    );
  }
}
