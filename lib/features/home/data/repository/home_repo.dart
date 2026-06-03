import 'package:car/core/error/failures.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/home/data/model/add_booking_permission_model.dart';
import 'package:car/features/home/data/model/add_booking_permission_response_model.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract interface class HomeRepo {
  Future<Either<Failure, CarsModelsResponse>> getCarsModels();
  Future<Either<Failure, List<GetBrandCarsDataModel>>> getBrandCars(String brandId);
  Future<Either<Failure, AddBookingPermissionResponseModel>> addBookingPermission(
    AddBookingPermissionModel model,
  );
  Future<Either<Failure, List<GetBrandCarsDataModel>>> fetchAllCars(
    String? brandId,
    String? frommakeyear,
    String? tomakeyear,
    int? fromprice,
    int? toprice,
    String? fuelType,
  );
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
  Future<Either<Failure, AddBookingPermissionResponseModel>> addBookingPermission(
    AddBookingPermissionModel model,
  ) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.post(EndPoints.addbooking, body: model.toJson());
        return AddBookingPermissionResponseModel.fromJson(response);
      },
    );
  }

  @override
  Future<Either<Failure, List<GetBrandCarsDataModel>>> getBrandCars(String brandId) async {
    if (brandId.isEmpty || brandId == 'null') {
      return const Right([]);
    }
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

  @override
  Future<Either<Failure, List<GetBrandCarsDataModel>>> fetchAllCars(
    String? brandId,
    String? frommakeyear,
    String? tomakeyear,
    int? fromprice,
    int? toprice,
    String? fuelType,
  ) async {
    return handleDioRequest(
      request: () async {
        final queryParams = <String, String>{};
        queryParams['id'] = brandId ?? "null";
        if (frommakeyear != null) queryParams['frommakeyear'] = frommakeyear ?? 'null';
        if (tomakeyear != null) queryParams['tomakeyear'] = tomakeyear ?? 'null';
        if (fromprice != null) queryParams['fromprice'] = fromprice.toString() ?? 'null';
        if (toprice != null) queryParams['toprice'] = toprice.toString() ?? 'null';
        if (fuelType != null) queryParams['FUEL_TYPE'] = fuelType ?? 'null';
        final queryString = queryParams.entries.map((e) => '${e.key}=${e.value}').join('&');
        final fullPath = '${EndPoints.getprandcars}?$queryString';
        if (kDebugMode) {
          print('Requested Decoded URL: $fullPath');
        }
        try {
          final response = await apiConsumer.get(fullPath);
          final data = response['Data'];
          if (data is String) {
            return GetBrandCarsDataModel.listFromResponse(data);
          } else if (data is List) {
            return List<GetBrandCarsDataModel>.from(
              data.map((e) => GetBrandCarsDataModel.fromJson(e)),
            );
          }
          return [];
        } on DioException catch (e) {
          if (e.response?.statusCode == 500 && e.response?.data != null) {
            final rawData = e.response!.data;
            final data = rawData is Map ? rawData['Data'] : null;
            if (data is String && data != 'null' && data.isNotEmpty && data != '[]') {
              if (kDebugMode) print('[fetchAllCars] Got 500 but found valid Data, parsing...');
              return GetBrandCarsDataModel.listFromResponse(data);
            }
          }
          rethrow;
        }
      },
    );
  }
}
