import 'dart:convert';

import 'package:equatable/equatable.dart';

class CarsModelsResponse extends Equatable {
  final List<CarModel> cars;

  const CarsModelsResponse({required this.cars});

  factory CarsModelsResponse.fromJson(Map<String, dynamic> json) {
    final rawData = json['Data'];

    List<CarModel> parsedList = [];

    if (rawData != null && rawData is String) {
      final decoded = jsonDecode(rawData) as List;

      parsedList = decoded.map((e) => CarModel.fromJson(e)).toList();
    }

    return CarsModelsResponse(cars: parsedList);
  }

  @override
  List<Object?> get props => [cars];
}

class CarModel extends Equatable {
  final int groupCode;
  final String groupName;
  final String? groupEName;
  final int groupParent;
  final int groupLevel;
  final String picturePath;

  const CarModel({
    required this.groupCode,
    required this.groupName,
    this.groupEName,
    required this.groupParent,
    required this.groupLevel,
    required this.picturePath,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      groupCode: json['GROUP_CODE'] ?? 0,
      groupName: json['GROUP_NAME'] ?? '',
      groupEName: json['GROUP_ENAME'],
      groupParent: json['GROUP_PARENT'] ?? 0,
      groupLevel: json['GROUP_LEVEL'] ?? 0,
      picturePath: json['PICTUREPATH'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
    groupCode,
    groupName,
    groupEName,
    groupParent,
    groupLevel,
    picturePath,
  ];
}
