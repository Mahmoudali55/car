import 'package:car/core/error/failures.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:dartz/dartz.dart';

abstract interface class HomeRepo {
  Future<Either<Failure, CarsModelsResponse>> getCarsModels();
}

class HomeRepoImpl implements HomeRepo {
  @override
  final ApiConsumer apiConsumer;

  HomeRepoImpl(this.apiConsumer);

  @override
  Future<Either<Failure, CarsModelsResponse>> getCarsModels() async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(EndPoints.carsModel);
        return CarsModelsResponse.fromJson(response);
      },
    );
  }
}
