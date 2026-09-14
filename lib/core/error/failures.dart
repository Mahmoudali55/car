// lib/core/network/error_handler.dart

import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../network/status_code.dart';

/// Base class for all failures, holds an error message.
abstract class Failure {
  final String errMessage;
  const Failure(this.errMessage);
}

String? _extractMsgFromMap(Map<String, dynamic> map) {
  final val = map['Message'] ?? map['message'] ?? map['msg'] ?? map['MessageAr'] ?? map['MessageEn'];
  return val is String && val.isNotEmpty ? val : null;
}

/// Represents a failure coming from Dio / the server.
class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  /// Map Dio exceptions to our ServerFailure, extracting server‑side messages when present.
  factory ServerFailure.fromDioError(DioException dioError) {
    try {
      // Attempt to parse raw response data into a Map<String, dynamic>
      final raw = dioError.response?.data;
      Map<String, dynamic>? map;
      if (raw != null) {
        if (raw is Map<String, dynamic>) {
          map = raw;
        } else if (raw is String) {
          try {
            map = jsonDecode(raw) as Map<String, dynamic>;
          } catch (_) {
            map = null;
          }
        }
      }

      // If we got a JSON map with a message field, return it immediately
      if (map != null) {
        final serverMsg = _extractMsgFromMap(map);
        if (serverMsg != null) {
          return ServerFailure(serverMsg);
        }
      }

      // Otherwise fall back based on DioException type
      switch (dioError.type) {
        case DioExceptionType.connectionTimeout:
          return ServerFailure('Connection timeout with API server');
        case DioExceptionType.sendTimeout:
          return ServerFailure('Send timeout with API server');
        case DioExceptionType.receiveTimeout:
          return ServerFailure('Receive timeout with API server');
        case DioExceptionType.cancel:
          return ServerFailure('Request to API server was cancelled');
        case DioExceptionType.connectionError:
          return ServerFailure('No internet connection');
        case DioExceptionType.unknown:
          return ServerFailure('Unexpected error, please try again!');
        case DioExceptionType.badResponse:
          return ServerFailure.fromResponse(
            dioError.response?.statusCode,
            map ?? raw,
          );
        default:
          return ServerFailure('Oops! There was an error, please try again.');
      }
    } catch (e, stack) {
      log('ServerFailure.fromDioError error: $e\n$stack');
      return ServerFailure('An unknown error occurred');
    }
  }

  /// Handle different status codes, but always prefer the server‑sent "message" if available.
  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    try {
      if (response is Map<String, dynamic>) {
        final serverMsg = _extractMsgFromMap(response);
        if (serverMsg != null) {
          return ServerFailure(serverMsg);
        }
      }

      switch (statusCode) {
        case StatusCode.badRequest:
        case StatusCode.unauthorized:
        case StatusCode.forbidden:
          return ServerFailure('Invalid request, please check your input');
        case StatusCode.notFound:
          return ServerFailure('Requested resource not found');
        case StatusCode.internalServerError:
          return ServerFailure('Internal server error, please try later');
        default:
          return ServerFailure('Request failed with status $statusCode');
      }
    } catch (e) {
      return ServerFailure('Failed to parse server response');
    }
  }
}

/// Executes any Dio request and returns either the parsed data or a Failure.
Future<Either<Failure, T>> handleDioRequest<T>({
  required Future<T> Function() request,
}) async {
  try {
    final response = await request();
    return Right(response);
  } on DioException catch (e) {
    // Debug logs
    log('[DioException] ➜ ${e.message}');
    if (e.response?.data != null) {
      final serverMsg = _extractServerMessage(e.response!.data);
      log('[Server message] ➜ $serverMsg');
    }
    return Left(ServerFailure.fromDioError(e));
  } catch (e, stack) {
    log('[Unknown Error] ➜ $e');
    log('[StackTrace] ➜ $stack');
    return Left(ServerFailure(e.toString()));
  }
}

/// Helper to grab "message" from raw response data for logging.
String? _extractServerMessage(dynamic rawData) {
  try {
    if (rawData is Map<String, dynamic>) {
      return _extractMsgFromMap(rawData);
    }
    if (rawData is String) {
      final decoded = jsonDecode(rawData);
      if (decoded is Map<String, dynamic>) {
        return _extractMsgFromMap(decoded);
      }
    }
  } catch (_) {}
  return null;
}

