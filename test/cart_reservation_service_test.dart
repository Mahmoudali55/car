import 'dart:io';

import 'package:car/core/error/failures.dart';
import 'package:car/features/admin/data/model/cars_response_model.dart' as admin_model;
import 'package:car/features/cart/presentation/view/cubit/cart_reservation_service.dart';
import 'package:car/features/home/data/model/add_booking_permission_model.dart';
import 'package:car/features/home/data/model/add_booking_permission_response_model.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_model.dart';
import 'package:car/features/home/data/model/cancel_reserved_car_response_model.dart';
import 'package:car/features/home/data/model/cars_models_response.dart';
import 'package:car/features/home/data/repository/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';

class _FakeHomeRepo implements HomeRepo {
  final apiConsumer = null;

  @override
  Future<Either<Failure, CarsModelsResponse>> getCarsModels() async =>
      const Right(CarsModelsResponse(cars: []));

  @override
  Future<Either<Failure, List<GetBrandCarsDataModel>>> getBrandCars(String brandId) async =>
      const Right([]);

  @override
  Future<Either<Failure, AddBookingPermissionResponseModel>> addBookingPermission(
    AddBookingPermissionModel model,
  ) async => const Right(AddBookingPermissionResponseModel(success: true, lpoNo: '', msg: 'ok'));

  @override
  Future<Either<Failure, List<GetBrandCarsDataModel>>> fetchAllCars(
    int? brandId,
    String? frommakeyear,
    String? tomakeyear,
    int? fromprice,
    int? toprice,
    String? fuelType,
  ) async => const Right([]);

  @override
  Future<Either<Failure, CancelReservedCarResponseModel>> cancelreservedcar(
    CancelReservedCarModel model,
  ) async => const Right(CancelReservedCarResponseModel(success: true, msg: 'ok'));
}

void main() {
  setUpAll(() async {
    final tempDir = await Directory.systemTemp.createTemp('hive_test');
    Hive.init(tempDir.path);
    await Hive.openBox('app');
  });

  tearDownAll(() async {
    if (Hive.isBoxOpen('app')) {
      await Hive.box('app').close();
    }
  });

  test('reuses the first reservation time when rescheduled without a new timestamp', () {
    final service = CartReservationService(homeRepo: _FakeHomeRepo());
    final car = admin_model.CarModel(itemCode: 'CAR-1');
    final firstReservedAt = DateTime.now().add(const Duration(minutes: 5));

    service.scheduleExpiryForModel(car: car, onExpired: () {}, reservedAt: firstReservedAt);

    service.scheduleExpiryForModel(car: car, onExpired: () {});

    expect(
      service.expiryTimeFor(car.itemCode ?? ''),
      firstReservedAt.add(CartReservationService.reservationWindow),
    );

    service.disposeAll();
  });
}
