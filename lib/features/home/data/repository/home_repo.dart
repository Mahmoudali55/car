import 'package:car/core/error/failures.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:dartz/dartz.dart';

abstract interface class HomeRepo {
  Future<Either<Failure, CarsModelsResponse>> getCarsModels();
  Future<Either<Failure, List<GetBrandCarsDataModel>>> getBrandCars(String brandId);
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

  @override
  Future<Either<Failure, List<GetBrandCarsDataModel>>> getBrandCars(String brandId) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.get(
          EndPoints.getprandcars,
          queryParameters: {'id': brandId},
        );

        final data = response['Data'];
        if (data is String) {
          return GetBrandCarsDataModel.listFromResponse(data);
        } else if (data is List) {
          return List<GetBrandCarsDataModel>.from(
            data.map((e) => GetBrandCarsDataModel.fromJson(e)),
          );
        }
        return [];
      },
    );
  }
}
