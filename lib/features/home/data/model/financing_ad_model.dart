import 'dart:convert';

import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/network/contants.dart';
import 'package:car/features/home/data/model/brand_cars_data_model.dart';
import 'package:equatable/equatable.dart';

class FinancingAdModel extends Equatable {
  final int? programId;
  final String? programName;
  final bool? isActive;
  final String? bankOrProvider;
  final String? bankName;
  final String? bankNameEng;
  final String? startDate;
  final String? endDate;
  final double? firstInstallmentPct;
  final double? lastInstallmentPct;
  final double? adminFeesPct;
  final String? programPic;
  final double? interestRate;
  final int? totalMonths;
  final String? modelName;
  final int? modelYear;
  final double? price;
  final String? itemCode;
  final String? itemName;
  final String? storeCode;
  final int? carStatus;
  final String? chassisNo;
  final String? motorNo;
  final String? bodyColor;
  final String? kilometerReading;
  final dynamic transmission;
  final dynamic cylinder;
  final dynamic powerHourse;
  final dynamic fuelCapacity;
  final dynamic fuelType;
  final int? seatNo;
  final int? doorNo;
  final dynamic usedClient;
  final int? addType;
  final int? colorCode;
  final String? boardNo;
  final int? makeYear;
  final bool? mobileShow;
  final String? color;
  final String? carImage;

  const FinancingAdModel({
    this.programId,
    this.programName,
    this.isActive,
    this.bankOrProvider,
    this.bankName,
    this.bankNameEng,
    this.startDate,
    this.endDate,
    this.firstInstallmentPct,
    this.lastInstallmentPct,
    this.adminFeesPct,
    this.programPic,
    this.interestRate,
    this.totalMonths,
    this.modelName,
    this.price,
    this.itemCode,
    this.itemName,
    this.storeCode,
    this.carStatus,
    this.chassisNo,
    this.motorNo,
    this.bodyColor,
    this.kilometerReading,
    this.transmission,
    this.cylinder,
    this.powerHourse,
    this.fuelCapacity,
    this.fuelType,
    this.seatNo,
    this.doorNo,
    this.usedClient,
    this.addType,
    this.colorCode,
    this.boardNo,
    this.makeYear,
    this.modelYear,
    this.mobileShow,
    this.color,
    this.carImage,
  });

  factory FinancingAdModel.fromJson(Map<String, dynamic> json) {
    return FinancingAdModel(
      programId: (json['ProgramID'] as num?)?.toInt(),
      programName: json['ProgramName']?.toString(),
      isActive: json['IsActive'] as bool?,
      bankOrProvider: json['BankOrProvider']?.toString(),
      bankName: (json['BankName'] ?? json['BANK_NAME'] ?? json['BankOrProviderName'])?.toString(),
      bankNameEng: (json['BankNameEng'] ?? json['BANK_NAME_ENG'] ?? json['BankOrProviderNameEng'])
          ?.toString(),
      startDate: json['StartDate']?.toString(),
      endDate: json['EndDate']?.toString(),
      firstInstallmentPct: (json['FirstInstallmentPct'] as num?)?.toDouble(),
      lastInstallmentPct: (json['LastInstallmentPct'] as num?)?.toDouble(),
      adminFeesPct: (json['AdminFeesPct'] as num?)?.toDouble(),
      programPic: json['programpic']?.toString(),
      interestRate: (json['InterestRate'] as num?)?.toDouble(),
      totalMonths: ((json['TotalMonths'] ?? json['Months'] ?? json['DurationMonths']) as num?)
          ?.toInt(),
      modelName: json['modelName']?.toString(),
      modelYear: (json['ModelYear'] as num?)?.toInt(),
      price: (json['Price'] as num?)?.toDouble(),
      itemCode: json['ITEM_CODE']?.toString(),
      itemName: json['ITEM_NAME']?.toString(),
      storeCode: json['STORE_CODE']?.toString(),
      carStatus: (json['CAR_STATUS'] as num?)?.toInt(),
      chassisNo: json['CHASSIS_NO']?.toString(),
      motorNo: json['MOTOR_NO']?.toString(),
      bodyColor: json['BODY_COLOR']?.toString(),
      kilometerReading: json['KILOMETER_READING']?.toString(),
      transmission: json['TRANSMISSION'],
      cylinder: json['CYLINDER'],
      powerHourse: json['POWER_HOURSE'],
      fuelCapacity: json['FUEL_CAPACITY'],
      fuelType: json['FUEL_TYPE'],
      seatNo: (json['SEAT_NO'] as num?)?.toInt(),
      doorNo: (json['DOOR_NO'] as num?)?.toInt(),
      usedClient: json['USED_CLIENT'],
      addType: (json['ADD_TYPE'] as num?)?.toInt(),
      colorCode: (json['COLOR_CODE'] as num?)?.toInt(),
      boardNo: json['BOARD_NO']?.toString(),
      makeYear: (json['MAKE_YEAR'] as num?)?.toInt(),
      mobileShow: json['MobileShow'] as bool?,
      color: json['Color']?.toString(),
      carImage: json['carimage']?.toString(),
    );
  }

  static List<FinancingAdModel> listFromResponse(dynamic data) {
    if (data == null) return [];
    final List<dynamic> jsonList = data is String ? jsonDecode(data) : data;
    return jsonList.map((e) => FinancingAdModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  String get displayPicUrl {
    final rawPic = (programPic != null && programPic!.isNotEmpty)
        ? programPic
        : (carImage != null && carImage!.isNotEmpty ? carImage!.split(',').first : null);
    if (rawPic == null || rawPic.isEmpty) return '';
    if (rawPic.startsWith('http://') || rawPic.startsWith('https://')) return rawPic;
    final cleaned = rawPic.replaceAll('../../Img/Emp/', '').replaceAll('../..', '');
    return '${Constants.baseImage}$cleaned';
  }

  String? get displayBankName {
    final apiName = bankName?.trim();
    if (apiName != null && apiName.isNotEmpty) return apiName;

    final provider = bankOrProvider?.trim();
    const bankNames = {'1': 'بنك الإنماء', '2': 'مصرف الراجحي'};
    return bankNames[provider] ??
        (provider != null && provider.isNotEmpty && double.tryParse(provider) == null
            ? provider
            : null);
  }

  double get monthlyInstallmentWithVat {
    final months = totalMonths ?? 60;
    if (months <= 0) return 0;
    final firstAmount = priceWithVat * ((firstInstallmentPct ?? 0) / 100);
    final lastAmount = priceWithVat * ((lastInstallmentPct ?? 0) / 100);
    final financedAmount = priceWithVat - firstAmount - lastAmount;
    final years = months / 12;
    final totalInterest = financedAmount * ((interestRate ?? 0) / 100) * years;
    return (financedAmount + totalInterest) / months;
  }

  List<String> get allCarImages {
    if (carImage == null || carImage!.isEmpty) return [];
    return carImage!.split(',').map((img) {
      if (img.startsWith('http://') || img.startsWith('https://')) return img;
      final cleaned = img.replaceAll('../../Img/Emp/', '').replaceAll('../..', '');
      return '${Constants.baseImage}$cleaned';
    }).toList();
  }

  GetBrandCarsDataModel toCarDataModel() {
    final images = allCarImages;
    final carPrice = priceWithVat;
    final months = totalMonths ?? 60;
    final firstAmount = carPrice * ((firstInstallmentPct ?? 0) / 100);
    final lastAmount = carPrice * ((lastInstallmentPct ?? 0) / 100);
    final financedAmount = carPrice - firstAmount - lastAmount;
    final years = months / 12;
    final totalInterest = financedAmount * ((interestRate ?? 0) / 100) * years;
    final monthlyInstallment = months > 0 ? (financedAmount + totalInterest) / months : null;

    return GetBrandCarsDataModel(
      groupCode: 0,
      groupName: '',
      grName: '',
      groupParent: 0,
      groupLevel: 0,
      price: price?.toStringAsFixed(0),
      interestRate: interestRate,
      monthlyInstallment: monthlyInstallment,
      itemCode: itemCode ?? '',
      itemType: 0,
      itemName: itemName ?? modelName ?? '',
      groupCode1: 0,
      storeCode: storeCode ?? '1',
      carStatus: carStatus ?? 1,
      carType: 0,
      chassisNo: chassisNo ?? '',
      motorNo: motorNo,
      bodyColor: bodyColor ?? color ?? '',
      kilometerReading: kilometerReading,
      transmission: (transmission is int)
          ? transmission
          : (int.tryParse(transmission?.toString() ?? '1') ?? 1),
      cylinder: cylinder?.toString() ?? '4',
      powerHourse: powerHourse?.toString() ?? '',
      fuelCapacity: fuelCapacity?.toString() ?? '',
      fuelType: fuelType?.toString() ?? 'بنزين',
      seatNo: seatNo ?? 5,
      doorNo: doorNo ?? 4,
      usedClient: usedClient?.toString(),
      addType: addType ?? 1,
      colorCode: colorCode ?? 1,
      boardNo: boardNo,
      makeYear: makeYear ?? modelYear ?? 2025,
      notifyType: 0,
      notifyDate: null,
      supplierCd: 0,
      buyDate: '',
      trNo: 0,
      customsCardNo: null,
      reasonId: 0,
      mobileShow: mobileShow ?? true,
      color: color ?? bodyColor ?? '',
      extraImages: images,
      carImage: images.isNotEmpty ? images.first : null,
    );
  }

  double get priceWithVat {
    final vatPercentage = double.tryParse(HiveMethods.getVatNumber()?.toString() ?? '') ?? 0;
    return (price ?? 0) * (1 + vatPercentage / 100);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': itemName ?? modelName ?? programName ?? 'سيارة',
      'groupCode': '0',
      'itemCode': itemCode ?? '0',
      'chassisNo': chassisNo ?? '',
      'image': displayPicUrl,
      'extraImages': allCarImages,
      'brand': programName ?? 'برنامج تمويلي',
      'price': price != null ? price!.toStringAsFixed(0) : '0',
      'year': (makeYear ?? modelYear ?? 2025).toString(),
      'mileage': kilometerReading != null ? '$kilometerReading كم' : '0 كم',
      'engine': cylinder != null ? '$cylinder Cyl' : 'V4',
      'video_id': 'D7O8J5vVf-M',
      'isFavorite': false,
      'carStatus': carStatus ?? 1,
      'carStatusText': '',
      'CHASSIS_NO': chassisNo ?? '',
      'MOTOR_NO': motorNo,
      'KILOMETER_READING': kilometerReading,
      'CYLINDER': cylinder,
      'POWER_HOURSE': powerHourse,
      'FUEL_CAPACITY': fuelCapacity,
      'SEAT_NO': seatNo,
      'DOOR_NO': doorNo,
      'Color': color ?? bodyColor ?? '',
      'BODY_COLOR': bodyColor ?? color ?? '',
      'FUEL_TYPE': fuelType ?? 'بنزين',
      'CUSTOMS_CARD_NO': null,
      'TRANSMISSION': transmission ?? 1,
      'MAKE_YEAR': makeYear ?? modelYear ?? 2025,
      'GR_NAME': programName ?? '',
      'GROUP_NAME': programName ?? '',
      'interestRate': interestRate,
      'firstInstallmentPct': firstInstallmentPct,
      'lastInstallmentPct': lastInstallmentPct,
      'adminFeesPct': adminFeesPct,
    };
  }

  @override
  List<Object?> get props => [
    programId,
    programName,
    isActive,
    bankOrProvider,
    bankName,
    bankNameEng,
    startDate,
    endDate,
    firstInstallmentPct,
    lastInstallmentPct,
    adminFeesPct,
    programPic,
    interestRate,
    totalMonths,
    modelName,
    modelYear,
    price,
    itemCode,
    itemName,
    carImage,
  ];
}
