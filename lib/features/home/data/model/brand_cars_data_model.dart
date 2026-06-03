import 'dart:convert';

import 'package:car/core/localization/app_locale_keys.dart';
import 'package:car/core/network/contants.dart';
import 'package:easy_localization/easy_localization.dart';
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

  // Mock/Extra fields for UI consistency
  final String? discount;
  final String? oldPrice;
  final String? installments;
  final String? cashPrice;
  final bool isFavorite;
  final bool isTamaraAvailable;
  final String videoId;

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
    this.discount,
    this.oldPrice,
    this.installments,
    this.cashPrice,
    this.isFavorite = false,
    this.isTamaraAvailable = true,
    this.videoId = 'D7O8J5vVf-M',
  });

  String _sanitizeImageUrl(String path) {
    if (path.isEmpty) return '';
    if (path.startsWith('http')) return path;
    final cleaned = path.replaceAll('../../Img/Emp/', '');
    // Ensure special characters and spaces are encoded for URL
    return Uri.parse('${Constants.baseImage}$cleaned').toString();
  }

  String get fullCarImage => _sanitizeImageUrl(carImage ?? '');

  List<String> get allImages {
    final List<String> images = [];
    if (fullCarImage.isNotEmpty) images.add(fullCarImage);
    for (var img in extraImages) {
      final full = _sanitizeImageUrl(img);
      if (full.isNotEmpty && !images.contains(full)) {
        images.add(full);
      }
    }
    return images;
  }

  String get formattedPrice {
    if (price == null || price!.isEmpty) return '---';
    return price!.replaceAll(RegExp(r'[^0-9,]'), '');
  }

  Map<String, dynamic> toMap() {
    return {
      'GROUP_CODE': groupCode,
      'GROUP_NAME': groupName,
      'GR_NAME': grName,
      'GROUP_PARENT': groupParent,
      'GROUP_LEVEL': groupLevel,
      'PRICE': price,
      'ITEM_CODE': itemCode,
      'ITEM_TYPE': itemType,
      'ITEM_NAME': itemName,
      'ITEM_ENAME': itemEName,
      'ITEM_SUB': itemSub,
      'NOTES': notes,
      'GROUP_CODE1': groupCode1,
      'STORE_CODE': storeCode,
      'CAR_STATUS': carStatus,
      'CAR_TYPE': carType,
      'CAR_SPECIFICATION': carSpecification,
      'CHASSIS_NO': chassisNo,
      'MOTOR_NO': motorNo,
      'BODY_COLOR': bodyColor,
      'KILOMETER_READING': kilometerReading,
      'TRANSMISSION': transmission,
      'CYLINDER': cylinder,
      'POWER_HOURSE': powerHourse,
      'FUEL_CAPACITY': fuelCapacity,
      'FUEL_TYPE': fuelType,
      'SEAT_NO': seatNo,
      'DOOR_NO': doorNo,
      'USED_CLIENT': usedClient,
      'ADD_TYPE': addType,
      'COLOR_CODE': colorCode,
      'BOARD_NO': boardNo,
      'MAKE_YEAR': makeYear,
      'NOTIFY_TYPE': notifyType,
      'NOTIFY_DATE': notifyDate,
      'SUPPLIER_CD': supplierCd,
      'BUY_DATE': buyDate,
      'TR_NO': trNo,
      'CUSTOMS_CARD_NO': customsCardNo,
      'REASON_ID': reasonId,
      'MobileShow': mobileShow,
      'carimage': carImage,
      'Color': color,
      // For backward compatibility and UI usage
      'name': itemName,
      'image': fullCarImage,
      'price': price,
      'brand': groupName,
      'year': makeYear.toString(),
      'mileage': kilometerReading ?? '0',
      'engine': cylinder,
      'discount': discount,
      'oldPrice': oldPrice,
      'installments': installments,
      'cashPrice': cashPrice ?? price,
      'isFavorite': isFavorite,
      'isTamaraAvailable': isTamaraAvailable,
      'video_id': videoId,
    };
  }

  String get carStatusText {
    switch (carStatus) {
      case 1:
        return AppLocaleKey.agentCarAvailable.tr();
      case 2:
        return AppLocaleKey.agentCarReserved.tr();
      case 3:
        return AppLocaleKey.agentCarSold.tr();
      default:
        return '';
    }
  }

  GetBrandCarsDataModel copyWith({
    List<String>? extraImages,
    bool? isFavorite,
  }) {
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
      discount: discount,
      oldPrice: oldPrice,
      installments: installments,
      cashPrice: cashPrice,
      isFavorite: isFavorite ?? this.isFavorite,
      isTamaraAvailable: isTamaraAvailable,
      videoId: videoId,
    );
  }

  factory GetBrandCarsDataModel.fromJson(Map<String, dynamic> json) {
    return GetBrandCarsDataModel(
      groupCode: int.tryParse(json['GROUP_CODE']?.toString() ?? json['groupCode']?.toString() ?? '0') ?? 0,
      groupName: json['GROUP_NAME'] ?? json['brand'] ?? json['groupName'] ?? '',
      grName: json['GR_NAME'] ?? json['grName'] ?? '',
      groupParent: int.tryParse(json['GROUP_PARENT']?.toString() ?? json['groupParent']?.toString() ?? '0') ?? 0,
      groupLevel: int.tryParse(json['GROUP_LEVEL']?.toString() ?? json['groupLevel']?.toString() ?? '0') ?? 0,
      price: json['PRICE']?.toString() ?? json['price']?.toString(),
      itemCode: json['ITEM_CODE']?.toString() ?? json['itemCode']?.toString() ?? '',
      itemType: int.tryParse(json['ITEM_TYPE']?.toString() ?? json['itemType']?.toString() ?? '0') ?? 0,
      itemName: json['ITEM_NAME'] ?? json['name'] ?? json['itemName'] ?? '',
      itemEName: json['ITEM_ENAME'] ?? json['itemEName'],
      itemSub: json['ITEM_SUB'] ?? json['itemSub'],
      notes: json['NOTES'] ?? json['notes'],
      groupCode1: int.tryParse(json['GROUP_CODE1']?.toString() ?? json['groupCode1']?.toString() ?? '0') ?? 0,
      storeCode: json['STORE_CODE']?.toString() ?? json['storeCode']?.toString() ?? '',
      carStatus: int.tryParse(json['CAR_STATUS']?.toString() ?? json['carStatus']?.toString() ?? '0') ?? 0,
      carType: int.tryParse(json['CAR_TYPE']?.toString() ?? json['carType']?.toString() ?? '0') ?? 0,
      carSpecification: json['CAR_SPECIFICATION']?.toString() ?? json['carSpecification']?.toString(),
      chassisNo: json['CHASSIS_NO']?.toString() ?? json['chassisNo']?.toString() ?? '',
      motorNo: json['MOTOR_NO']?.toString() ?? json['motorNo']?.toString(),
      bodyColor: json['BODY_COLOR']?.toString() ?? json['bodyColor'] ?? json['interiorColor']?.toString() ?? '',
      kilometerReading: json['KILOMETER_READING']?.toString() ?? json['kilometerReading'] ?? json['mileage']?.toString(),
      transmission: int.tryParse(json['TRANSMISSION']?.toString() ?? json['transmission']?.toString() ?? '0') ?? 0,
      cylinder: json['CYLINDER']?.toString() ?? json['cylinder'] ?? json['engine']?.toString() ?? '',
      powerHourse: json['POWER_HOURSE']?.toString() ?? json['powerHourse']?.toString() ?? '',
      fuelCapacity: json['FUEL_CAPACITY']?.toString() ?? json['fuelCapacity']?.toString() ?? '',
      fuelType: json['FUEL_TYPE']?.toString() ?? json['fuelType']?.toString() ?? '',
      seatNo: int.tryParse(json['SEAT_NO']?.toString() ?? json['seatNo']?.toString() ?? '0') ?? 0,
      doorNo: int.tryParse(json['DOOR_NO']?.toString() ?? json['doorNo']?.toString() ?? '0') ?? 0,
      usedClient: json['USED_CLIENT']?.toString() ?? json['usedClient']?.toString(),
      addType: int.tryParse(json['ADD_TYPE']?.toString() ?? json['addType']?.toString() ?? '0') ?? 0,
      colorCode: int.tryParse(json['COLOR_CODE']?.toString() ?? json['colorCode']?.toString() ?? '0') ?? 0,
      boardNo: json['BOARD_NO']?.toString() ?? json['boardNo']?.toString(),
      makeYear: int.tryParse(json['MAKE_YEAR']?.toString() ?? json['makeYear']?.toString() ?? json['year']?.toString() ?? '') ?? 0,
      notifyType: int.tryParse(json['NOTIFY_TYPE']?.toString() ?? json['notifyType']?.toString() ?? '0') ?? 0,
      notifyDate: json['NOTIFY_DATE']?.toString() ?? json['notifyDate']?.toString(),
      supplierCd: int.tryParse(json['SUPPLIER_CD']?.toString() ?? json['supplierCd']?.toString() ?? '0') ?? 0,
      buyDate: json['BUY_DATE']?.toString() ?? json['buyDate']?.toString() ?? '',
      trNo: int.tryParse(json['TR_NO']?.toString() ?? json['trNo']?.toString() ?? '0') ?? 0,
      customsCardNo: json['CUSTOMS_CARD_NO']?.toString() ?? json['customsCardNo']?.toString(),
      reasonId: int.tryParse(json['REASON_ID']?.toString() ?? json['reasonId']?.toString() ?? '0') ?? 0,
      mobileShow: json['MobileShow']?.toString() ?? json['mobileShow']?.toString(),
      carImage: json['carimage']?.toString() ?? json['image']?.toString() ?? '',
      color: json['Color']?.toString() ?? json['color'] ?? json['exteriorColor']?.toString() ?? '',
      discount: json['discount']?.toString(),
      oldPrice: json['oldPrice']?.toString(),
      installments: json['installments']?.toString() ?? json['installmentPrice']?.toString(),
      cashPrice: json['cashPrice']?.toString(),
      isFavorite: json['isFavorite'] ?? false,
      isTamaraAvailable: json['isTamaraAvailable'] ?? true,
      videoId: json['video_id']?.toString() ?? 'D7O8J5vVf-M',
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
    extraImages,
    discount,
    oldPrice,
    installments,
    cashPrice,
    isFavorite,
    isTamaraAvailable,
    videoId,

  ];
}
