import 'dart:convert';

import 'package:equatable/equatable.dart';

class OfferModel extends Equatable {
  final int listNo;
  final int listType;
  final String? actListNo;
  final String? listDate;
  final String? listDesc;
  final String? analytical;
  final int customerNo;
  final int represCode;
  final int resType;
  final int areaNo;
  final String? paymentType;
  final String? taamedNo;
  final String? taamedDate;
  final String? lastDate;
  final double? guarPrimary;
  final double? guarFinal;
  final int? deliveryPeriod;
  final int? listPeriod;
  final String? begDate;
  final String? endDate;
  final String? receivePlace;
  final String? notes;
  final String? terms;
  final double total;
  final String customerName;
  final String represName;
  final String? areaName;

  const OfferModel({
    required this.listNo,
    required this.listType,
    this.actListNo,
    this.listDate,
    this.listDesc,
    this.analytical,
    required this.customerNo,
    required this.represCode,
    required this.resType,
    required this.areaNo,
    this.paymentType,
    this.taamedNo,
    this.taamedDate,
    this.lastDate,
    this.guarPrimary,
    this.guarFinal,
    this.deliveryPeriod,
    this.listPeriod,
    this.begDate,
    this.endDate,
    this.receivePlace,
    this.notes,
    this.terms,
    required this.total,
    required this.customerName,
    required this.represName,
    this.areaName,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      listNo: _toInt(json['LIST_NO']),
      listType: _toInt(json['LIST_TYPE']),
      actListNo: json['ACT_LIST_NO']?.toString(),

      listDate: json['LIST_DATE']?.toString(),
      listDesc: json['LIST_DESC']?.toString(),
      analytical: json['ANALYTICAL']?.toString(),

      customerNo: _toInt(json['CUSTOMER_NO']),
      represCode: _toInt(json['REPRES_CODE']),
      resType: _toInt(json['RES_TYPE']),
      areaNo: _toInt(json['AREA_NO']),

      paymentType: json['PAYMENT_TYPE']?.toString(),
      taamedNo: json['TAAMED_NO']?.toString(),
      taamedDate: json['TAAMED_DATE']?.toString(),
      lastDate: json['LAST_DATE']?.toString(),

      guarPrimary: _toDoubleNullable(json['GUAR_PRIMARY']),
      guarFinal: _toDoubleNullable(json['GUAR_FINAL']),
      deliveryPeriod: _toIntNullable(json['DELIVERY_PERIOD']),
      listPeriod: _toIntNullable(json['LIST_PERIOD']),

      begDate: json['BEG_DATE']?.toString(),
      endDate: json['END_DATE']?.toString(),

      receivePlace: json['RECEIVE_PLACE']?.toString(),
      notes: json['NOTES']?.toString(),
      terms: json['TERMS']?.toString(),

      total: _toDouble(json['TOTAL']),

      customerName: json['CUSTOMERNAME']?.toString() ?? '',
      represName: json['REPRES_NAME']?.toString() ?? '',
      areaName: json['AREA_NAME']?.toString(),
    );
  }

  static int _toInt(dynamic value) {
    if (value == null) return 0;
    return int.tryParse(value.toString()) ?? 0;
  }

  static int? _toIntNullable(dynamic value) {
    if (value == null) return null;
    return int.tryParse(value.toString());
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0;
    return double.tryParse(value.toString()) ?? 0;
  }

  static double? _toDoubleNullable(dynamic value) {
    if (value == null) return null;
    return double.tryParse(value.toString());
  }

  @override
  List<Object?> get props => [
    listNo,
    listType,
    actListNo,
    listDate,
    listDesc,
    analytical,
    customerNo,
    represCode,
    resType,
    areaNo,
    paymentType,
    taamedNo,
    taamedDate,
    lastDate,
    guarPrimary,
    guarFinal,
    deliveryPeriod,
    listPeriod,
    begDate,
    endDate,
    receivePlace,
    notes,
    terms,
    total,
    customerName,
    represName,
    areaName,
  ];
  static List<OfferModel> listFromResponse(String data) {
    final decoded = jsonDecode(data);

    if (decoded is! List || decoded.length < 2) {
      return [];
    }

    final List<dynamic> items = decoded[1];

    return items.map((e) => OfferModel.fromJson(Map<String, dynamic>.from(e))).toList();
  }
}
