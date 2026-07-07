import 'dart:convert';

import 'package:equatable/equatable.dart';

class SendOtpModel extends Equatable {
  final String mobileNumber;

  const SendOtpModel({required this.mobileNumber});

  factory SendOtpModel.fromJson(Map<String, dynamic> json) {
    return SendOtpModel(mobileNumber: json['MobileNumber'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'MobileNumber': mobileNumber};
  }

  SendOtpModel copyWith({String? mobileNumber}) {
    return SendOtpModel(mobileNumber: mobileNumber ?? this.mobileNumber);
  }

  @override
  List<Object?> get props => [mobileNumber];

  @override
  String toString() => jsonEncode(toJson());
}
