import 'dart:convert';

import 'package:equatable/equatable.dart';

class GetBrandCarsDataModel extends Equatable {
  final int groupCode;
  final String groupName;
  final String grName;
  final int groupParent;
  final int groupLevel;
  final String? price;
  final String itemCode;
  final int itemType;
  final String itemName;
  final String? itemEName;
  final String? itemSub;
  final String? notes;
  final int groupCode1;
  final String storeCode;
  final int carStatus;
  final int carType;
  final String? carSpecification;
  final String chassisNo;
  final String? motorNo;
  final String bodyColor;
  final String? kilometerReading;
  final int transmission;
  final String cylinder;
  final String powerHourse;
  final String fuelCapacity;
  final String fuelType;
  final int seatNo;
  final int doorNo;
  final String? usedClient;
  final int addType;
  final int colorCode;
  final String? boardNo;
  final int makeYear;
  final int notifyType;
  final String? notifyDate;
  final int supplierCd;
  final String buyDate;
  final int trNo;
  final String? customsCardNo;
  final int reasonId;
  final String? mobileShow;
  final String color;
  final List<String> extraImages;

  final String? carImage;

  const GetBrandCarsDataModel({
    required this.groupCode,
    required this.groupName,
    required this.grName,
    required this.groupParent,
    required this.groupLevel,
    this.price,
    required this.itemCode,
    required this.itemType,
    required this.itemName,
    this.itemEName,
    this.itemSub,
    this.notes,
    required this.groupCode1,
    required this.storeCode,
    required this.carStatus,
    required this.carType,
    this.carSpecification,
    required this.chassisNo,
    this.motorNo,
    required this.bodyColor,
    this.kilometerReading,
    required this.transmission,
    required this.cylinder,
    required this.powerHourse,
    required this.fuelCapacity,
    required this.fuelType,
    required this.seatNo,
    required this.doorNo,
    this.usedClient,
    required this.addType,
    required this.colorCode,
    this.boardNo,
    required this.makeYear,
    required this.notifyType,
    this.notifyDate,
    required this.supplierCd,
    required this.buyDate,
    required this.trNo,
    this.customsCardNo,
    required this.reasonId,
    this.mobileShow,
    required this.carImage,
    required this.color,
    this.extraImages = const [],
  });

  String get carStatusText {
    switch (carStatus) {
      case 1:
        return 'متاحة';
      case 2:
        return 'محجوزة';
      case 3:
        return 'غير متاحة';
      default:
        return '';
    }
  }

  GetBrandCarsDataModel copyWith({List<String>? extraImages}) {
    return GetBrandCarsDataModel(
      groupCode: groupCode,
      groupName: groupName,
      grName: grName,
      groupParent: groupParent,
      groupLevel: groupLevel,
      price: price,
      itemCode: itemCode,
      itemType: itemType,
      itemName: itemName,
      itemEName: itemEName,
      itemSub: itemSub,
      notes: notes,
      groupCode1: groupCode1,
      storeCode: storeCode,
      carStatus: carStatus,
      carType: carType,
      carSpecification: carSpecification,
      chassisNo: chassisNo,
      motorNo: motorNo,
      bodyColor: bodyColor,
      kilometerReading: kilometerReading,
      transmission: transmission,
      cylinder: cylinder,
      powerHourse: powerHourse,
      fuelCapacity: fuelCapacity,
      fuelType: fuelType,
      seatNo: seatNo,
      doorNo: doorNo,
      usedClient: usedClient,
      addType: addType,
      colorCode: colorCode,
      boardNo: boardNo,
      makeYear: makeYear,
      notifyType: notifyType,
      notifyDate: notifyDate,
      supplierCd: supplierCd,
      buyDate: buyDate,
      trNo: trNo,
      customsCardNo: customsCardNo,
      reasonId: reasonId,
      mobileShow: mobileShow,
      carImage: carImage,
      color: color,
      extraImages: extraImages ?? this.extraImages,
    );
  }

  factory GetBrandCarsDataModel.fromJson(Map<String, dynamic> json) {
    return GetBrandCarsDataModel(
      groupCode: json['GROUP_CODE'] ?? 0,
      groupName: json['GROUP_NAME'] ?? '',
      grName: json['GR_NAME'] ?? '',
      groupParent: json['GROUP_PARENT'] ?? 0,
      groupLevel: json['GROUP_LEVEL'] ?? 0,
      price: json['PRICE']?.toString(),
      itemCode: json['ITEM_CODE'] ?? '',
      itemType: json['ITEM_TYPE'] ?? 0,
      itemName: json['ITEM_NAME'] ?? '',
      itemEName: json['ITEM_ENAME'],
      itemSub: json['ITEM_SUB'],
      notes: json['NOTES'],
      groupCode1: json['GROUP_CODE1'] ?? 0,
      storeCode: json['STORE_CODE'] ?? '',
      carStatus: json['CAR_STATUS'] ?? 0,
      carType: json['CAR_TYPE'] ?? 0,
      carSpecification: json['CAR_SPECIFICATION']?.toString(),
      chassisNo: json['CHASSIS_NO']?.toString() ?? '',
      motorNo: json['MOTOR_NO']?.toString(),
      bodyColor: json['BODY_COLOR']?.toString() ?? '',
      kilometerReading: json['KILOMETER_READING']?.toString(),
      transmission: json['TRANSMISSION'] ?? 0,
      cylinder: json['CYLINDER']?.toString() ?? '',
      powerHourse: json['POWER_HOURSE']?.toString() ?? '',
      fuelCapacity: json['FUEL_CAPACITY']?.toString() ?? '',
      fuelType: json['FUEL_TYPE']?.toString() ?? '',
      seatNo: json['SEAT_NO'] ?? 0,
      doorNo: json['DOOR_NO'] ?? 0,
      usedClient: json['USED_CLIENT']?.toString(),
      addType: json['ADD_TYPE'] ?? 0,
      colorCode: json['COLOR_CODE'] ?? 0,
      boardNo: json['BOARD_NO']?.toString(),
      makeYear: json['MAKE_YEAR'] ?? 0,
      notifyType: json['NOTIFY_TYPE'] ?? 0,
      notifyDate: json['NOTIFY_DATE']?.toString(),
      supplierCd: json['SUPPLIER_CD'] ?? 0,
      buyDate: json['BUY_DATE']?.toString() ?? '',
      trNo: json['TR_NO'] ?? 0,
      customsCardNo: json['CUSTOMS_CARD_NO']?.toString(),
      reasonId: json['REASON_ID'] ?? 0,
      mobileShow: json['MobileShow']?.toString(),
      carImage: json['carimage']?.toString() ?? '',
      color: json['Color']?.toString() ?? '',
    );
  }

  static List<GetBrandCarsDataModel> listFromResponse(String data) {
    final decoded = jsonDecode(data);
    final allCars = List<GetBrandCarsDataModel>.from(
      decoded.map((e) => GetBrandCarsDataModel.fromJson(e)),
    );

    final Map<int, GetBrandCarsDataModel> uniqueCarsMap = {};
    final Map<int, List<String>> imagesMap = {};

    for (var car in allCars) {
      if (!uniqueCarsMap.containsKey(car.groupCode)) {
        uniqueCarsMap[car.groupCode] = car;
      }
      if (!imagesMap.containsKey(car.groupCode)) {
        imagesMap[car.groupCode] = [];
      }
      if (car.carImage?.isNotEmpty == true && !imagesMap[car.groupCode]!.contains(car.carImage)) {
        imagesMap[car.groupCode]!.add(car.carImage!);
      }
    }

    return uniqueCarsMap.values.map((car) {
      return car.copyWith(extraImages: imagesMap[car.groupCode]);
    }).toList();
  }

  @override
  List<Object?> get props => [
    groupCode,
    groupName,
    grName,
    groupParent,
    groupLevel,
    price,
    itemCode,
    itemType,
    itemName,
    itemEName,
    itemSub,
    notes,
    groupCode1,
    storeCode,
    carStatus,
    carType,
    carSpecification,
    chassisNo,
    motorNo,
    bodyColor,
    kilometerReading,
    transmission,
    cylinder,
    powerHourse,
    fuelCapacity,
    fuelType,
    seatNo,
    doorNo,
    usedClient,
    addType,
    colorCode,
    boardNo,
    makeYear,
    notifyType,
    notifyDate,
    supplierCd,
    buyDate,
    trNo,
    customsCardNo,
    reasonId,
    mobileShow,
    carImage,
    color,
  ];
}
