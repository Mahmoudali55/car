import 'package:car/core/error/failures.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/admin/data/model/customer_model.dart';
import 'package:car/features/admin/data/model/representative_model.dart';
import 'package:car/features/admin/data/model/stock_statistics_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class AdminRepo {
  Future<Either<Failure, List<StockStatisticsModel>>> getcarscount();
  Future<Either<Failure, CarsModel>> getCars(int carstatus);
  Future<Either<Failure, List<RepresentativeModel>>> searchRepresentatives(String? searchVal);
  Future<Either<Failure, List<CustomerModel>>> searchCustomers(String? searchVal);
  Future<Either<Failure, List<CustomerModel>>> searchSuppliers(String? searchVal);
}

class AdminRepoImp implements AdminRepo {
  final ApiConsumer apiConsumer;

  AdminRepoImp({required this.apiConsumer});

  @override
  Future<Either<Failure, List<StockStatisticsModel>>> getcarscount() async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(EndPoints.getcarscount);
        return StockStatisticsModel.listFromResponse(response['Data']);
      },
    );
  }

  @override
  Future<Either<Failure, CarsModel>> getCars(int carstatus) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.getcars,
          queryParameters: {'carstatus': carstatus},
        );
        return CarsModel.fromJson(response);
      },
    );
  }

  @override
  Future<Either<Failure, List<RepresentativeModel>>> searchRepresentatives(
    String? searchVal,
  ) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.customer,
          queryParameters: {'TableName': 'sp_REPRES_DATA_search_sel', 'Searchval': searchVal},
        );
        return RepresentativeModel.listFromResponse(response['Data'] ?? response);
      },
    );
  }

  @override
  Future<Either<Failure, List<CustomerModel>>> searchCustomers(String? searchVal) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.customer,
          queryParameters: {'TableName': 'sp_CUSTOMER_DATA_search_sel', 'Searchval': searchVal},
        );
        return CustomerModel.listFromResponse(response['Data'] ?? response);
      },
    );
  }

  @override
  Future<Either<Failure, List<CustomerModel>>> searchSuppliers(String? searchVal) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.customer,
          queryParameters: {'TableName': 'sp_Supplier_DATA_search_sel', 'Searchval': searchVal},
        );
        return CustomerModel.listFromResponse(response['Data'] ?? response);
      },
    );
  }
}
