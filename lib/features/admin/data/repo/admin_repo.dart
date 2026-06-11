import 'package:car/core/error/failures.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart';
import 'package:car/features/admin/data/model/stock_statistics_model.dart';
import 'package:dartz/dartz.dart';

abstract interface class AdminRepo {
  Future<Either<Failure, List<StockStatisticsModel>>> getcarscount();
  Future<Either<Failure, CarsModel>> getCars(int carstatus);
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
}
