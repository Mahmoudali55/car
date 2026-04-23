import 'dart:developer';

import 'package:car/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

Future<Either<Failure, T>> handleDioRequest<T>({required Future<T> Function() request}) async {
  try {
    final response = await request();
    return Right(response);
  } on DioException catch (e) {
    log('[DioException] ➜ ${e.message}');
    log('[Response] ➜ ${e.response?.data}');

    return Left(ServerFailure.fromDioError(e));
  } catch (e, stack) {
    log('[Unknown Error] ➜ $e');
    log('[StackTrace] ➜ $stack');

    return Left(ServerFailure(e.toString()));
  }
}
