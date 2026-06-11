import 'dart:convert';

import 'package:equatable/equatable.dart';

class CarsModel extends Equatable {
  final List<CarModel> data;

  const CarsModel({required this.data});

  factory CarsModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> parsedData = json['Data'] != null ? jsonDecode(json['Data']) : [];

    return CarsModel(data: parsedData.map((e) => CarModel.fromJson(e)).toList());
  }

  @override
  List<Object?> get props => [data];
}

class CarModel extends Equatable {
  final String? itemCode;
  final String? itemName;
  final int? groupCode;
  final String? storeCode;
  final int? carStatus;
  final int? carType;
  final String? chassisNo;
  final String? bodyColor;
  final int? transmission;
  final String? fuelType;
  final int? makeYear;
  final double? costPrice;
  final int? colorCode;
  final bool? mobileShow;

  const CarModel({
    this.itemCode,
    this.itemName,
    this.groupCode,
    this.storeCode,
    this.carStatus,
    this.carType,
    this.chassisNo,
    this.bodyColor,
    this.transmission,
    this.fuelType,
    this.makeYear,
    this.costPrice,
    this.colorCode,
    this.mobileShow,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      itemCode: json['ITEM_CODE'],
      itemName: json['ITEM_NAME'],
      groupCode: json['GROUP_CODE'],
      storeCode: json['STORE_CODE'],
      carStatus: json['CAR_STATUS'],
      carType: json['CAR_TYPE'],
      chassisNo: json['CHASSIS_NO'],
      bodyColor: json['BODY_COLOR'],
      transmission: json['TRANSMISSION'],
      fuelType: json['FUEL_TYPE'],
      makeYear: json['MAKE_YEAR'],
      costPrice: (json['COST_PRICE'] as num?)?.toDouble(),
      colorCode: json['COLOR_CODE'],
      mobileShow: json['MobileShow'],
    );
  }

  @override
  List<Object?> get props => [
    itemCode,
    itemName,
    groupCode,
    storeCode,
    carStatus,
    carType,
    chassisNo,
    bodyColor,
    transmission,
    fuelType,
    makeYear,
    costPrice,
    colorCode,
    mobileShow,
  ];
}
