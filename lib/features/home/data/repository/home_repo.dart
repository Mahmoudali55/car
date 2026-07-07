import 'package:car/core/error/failures.dart';
import 'package:car/features/home/data/model/send_otp_model.dart';
import 'package:car/features/home/data/model/send_otp_response_model.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/features/home/data/model/add_booking_permission_model.dart';
import 'package:car/features/home/data/model/add_booking_permission_response_model.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_response_model.dart';
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
    int? brandId,
    String? frommakeyear,
    String? tomakeyear,
    int? fromprice,
    int? toprice,
    String? fuelType,
  );
  Future<Either<Failure, CancelReservedCarResponseModel>> cancelreservedcar(
    CancelReservedCarModel model,
  );
  Future<Either<Failure, SendOtpResponseModel>> sendOtp(SendOtpModel model);
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
        return GetBrandCarsDataModel.listFromResponse(response['Data']);
      },
    );
  }

  @override
  Future<Either<Failure, List<GetBrandCarsDataModel>>> fetchAllCars(
    int? brandId,
    String? frommakeyear,
    String? tomakeyear,
    int? fromprice,
    int? toprice,
    String? fuelType,
  ) async {
    return handleDioRequest(
      request: () async {
        final queryParams = {
          'id': brandId.toString() ?? null,
          'frommakeyear': frommakeyear ?? "",
          'tomakeyear': tomakeyear ?? "",
          'fromprice': fromprice.toString() ?? null,
          'toprice': toprice.toString() ?? null,
          'FUEL_TYPE': fuelType ?? "",
        };

        try {
          final response = await apiConsumer.get(
            EndPoints.getprandcars,
            queryParameters: queryParams,
          );
          return GetBrandCarsDataModel.listFromResponse(response['Data']);
        } on DioException catch (e) {
          if (e.response?.statusCode == 500) {
            final data = e.response?.data;
            final carsData = data is Map ? data['Data'] : null;
            if (carsData != null && carsData != 'null' && carsData != '[]') {
              if (kDebugMode) print('[fetchAllCars] Got 500 but found valid Data, parsing...');
              return GetBrandCarsDataModel.listFromResponse(carsData);
            }
          }
          rethrow;
        }
      },
    );
  }

  @override
  Future<Either<Failure, CancelReservedCarResponseModel>> cancelreservedcar(
    CancelReservedCarModel model,
  ) {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.post(EndPoints.cancelreservedcar, body: model.toJson());
        return CancelReservedCarResponseModel.fromJson(response);
      },
    );
  }

  @override
  Future<Either<Failure, SendOtpResponseModel>> sendOtp(SendOtpModel model) async {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.post(EndPoints.sendotp, body: model.toJson());
        return SendOtpResponseModel.fromJson(response);
      },
    );
  }
}
