import 'package:equatable/equatable.dart';

class RegisterResponseModel extends Equatable {
  final bool data;

  const RegisterResponseModel({required this.data});

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      data: json['Data'] ?? false,
    );
  }

  @override
  List<Object?> get props => [data];
}
