import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/network/api_consumer.dart';
import 'package:car/core/network/end_points.dart';
import 'package:car/core/network/handle_dio_request.dart';
import 'package:car/features/auth/data/model/login_request_model.dart';
import 'package:car/features/auth/data/model/login_response_model.dart';
import 'package:car/features/auth/data/model/register_request_model.dart';
import 'package:car/features/auth/data/model/register_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart' hide handleDioRequest;

abstract interface class AuthRepo {
  Future<Either<Failure, LoginResponse>> login({required LoginRequest request});
  Future<Either<Failure, RegisterResponseModel>> register({required RegisterRequestModel request});
  Future<Either<Failure, bool>> editFCM({required String userId, required String fcmToken});
  Future<void> logout();
}

class AuthRepoImpl implements AuthRepo {
  final ApiConsumer apiConsumer;
  AuthRepoImpl(this.apiConsumer);

  @override
  Future<void> logout() async {
    HiveMethods.deleteToken();
    // Clear other session data if necessary
  }

  @override
  Future<Either<Failure, LoginResponse>> login({required LoginRequest request}) {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.post(EndPoints.login, body: request.toJson());
        return LoginResponse.fromJson(response);
      },
    );
  }

  @override
  Future<Either<Failure, RegisterResponseModel>> register({required RegisterRequestModel request}) {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.post(EndPoints.register, body: request.toJson());
        return RegisterResponseModel.fromJson(response);
      },
    );
  }

  @override
  Future<Either<Failure, bool>> editFCM({required String userId, required String fcmToken}) {
    return handleDioRequest(
      request: () async {
        final response = await apiConsumer.put(
          EndPoints.editFCM,
          body: {
            "userid": userId,
            "FCM": fcmToken,
          },
        );
        return response['success'] ?? false;
      },
    );
  }
}
