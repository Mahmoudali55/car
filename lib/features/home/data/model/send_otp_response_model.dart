import 'dart:convert';

import 'package:equatable/equatable.dart';

class SendOtpResponseModel extends Equatable {
  final bool success;
  final String message;
  final MoraResponseModel? moraResponse;

  const SendOtpResponseModel({required this.success, required this.message, this.moraResponse});

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return SendOtpResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      moraResponse: json['moraResponse'] != null && json['moraResponse'].toString().isNotEmpty
          ? MoraResponseModel.fromJson(jsonDecode(json['moraResponse']))
          : null,
    );
  }

  @override
  List<Object?> get props => [success, message, moraResponse];
}

class MoraResponseModel extends Equatable {
  final MoraStatusModel status;
  final MoraDataModel data;

  const MoraResponseModel({required this.status, required this.data});

  factory MoraResponseModel.fromJson(Map<String, dynamic> json) {
    return MoraResponseModel(
      status: MoraStatusModel.fromJson(json['status']),
      data: MoraDataModel.fromJson(json['data']),
    );
  }

  @override
  List<Object?> get props => [status, data];
}

class MoraStatusModel extends Equatable {
  final int code;
  final String message;
  final bool error;
  final List<dynamic> validationErrors;

  const MoraStatusModel({
    required this.code,
    required this.message,
    required this.error,
    required this.validationErrors,
  });

  factory MoraStatusModel.fromJson(Map<String, dynamic> json) {
    return MoraStatusModel(
      code: json['code'] ?? 0,
      message: json['message'] ?? '',
      error: json['error'] ?? false,
      validationErrors: List<dynamic>.from(json['validation_errors'] ?? []),
    );
  }

  @override
  List<Object?> get props => [code, message, error, validationErrors];
}

class MoraDataModel extends Equatable {
  final String message;
  final int code;
  final int refId;

  const MoraDataModel({required this.message, required this.code, required this.refId});

  factory MoraDataModel.fromJson(Map<String, dynamic> json) {
    return MoraDataModel(
      message: json['message'] ?? '',
      code: json['code'] ?? 0,
      refId: json['ref_id'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [message, code, refId];
}
