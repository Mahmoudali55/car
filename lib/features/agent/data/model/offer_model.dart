import 'dart:convert';

import 'package:equatable/equatable.dart';

class OfferModel extends Equatable {
  final int listNo;
  final int listType;
  final int? actListNo;
  final String listDate;
  final String? listDesc;
  final String? analytical;
  final int customerNo;
  final int represCode;
  final int resType;
  final int areaNo;
  final String paymentType;
  final String? taamedNo;
  final String? taamedDate;
  final String? lastDate;
  final String? guarPrimary;
  final String? guarFinal;
  final String? deliveryPeriod;
  final String? listPeriod;
  final String begDate;
  final String endDate;
  final String? receivePlace;
  final String? notes;
  final String? terms;
  final double total;
  final String customerName;
  final String represName;
  final String areaName;

  const OfferModel({
    required this.listNo,
    required this.listType,
    this.actListNo,
    required this.listDate,
    this.listDesc,
    this.analytical,
    required this.customerNo,
    required this.represCode,
    required this.resType,
    required this.areaNo,
    required this.paymentType,
    this.taamedNo,
    this.taamedDate,
    this.lastDate,
    this.guarPrimary,
    this.guarFinal,
    this.deliveryPeriod,
    this.listPeriod,
    required this.begDate,
    required this.endDate,
    this.receivePlace,
    this.notes,
    this.terms,
    required this.total,
    required this.customerName,
    required this.represName,
    required this.areaName,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {
    return OfferModel(
      listNo: json['LIST_NO'] ?? 0,
      listType: json['LIST_TYPE'] ?? 0,
      actListNo: json['ACT_LIST_NO'],
      listDate: json['LIST_DATE'] ?? '',
      listDesc: json['LIST_DESC'],
      analytical: json['ANALYTICAL'],
      customerNo: json['CUSTOMER_NO'] ?? 0,
      represCode: json['REPRES_CODE'] ?? 0,
      resType: json['RES_TYPE'] ?? 0,
      areaNo: json['AREA_NO'] ?? 0,
      paymentType: json['PAYMENT_TYPE'] ?? '',
      taamedNo: json['TAAMED_NO'],
      taamedDate: json['TAAMED_DATE'],
      lastDate: json['LAST_DATE'],
      guarPrimary: json['GUAR_PRIMARY'],
      guarFinal: json['GUAR_FINAL'],
      deliveryPeriod: json['DELIVERY_PERIOD'],
      listPeriod: json['LIST_PERIOD'],
      begDate: json['BEG_DATE'] ?? '',
      endDate: json['END_DATE'] ?? '',
      receivePlace: json['RECEIVE_PLACE'],
      notes: json['NOTES'],
      terms: json['TERMS'],
      total: (json['TOTAL'] ?? 0).toDouble(),
      customerName: json['CUSTOMERNAME'] ?? '',
      represName: json['REPRES_NAME'] ?? '',
      areaName: json['AREA_NAME'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LIST_NO': listNo,
      'LIST_TYPE': listType,
      'ACT_LIST_NO': actListNo,
      'LIST_DATE': listDate,
      'LIST_DESC': listDesc,
      'ANALYTICAL': analytical,
      'CUSTOMER_NO': customerNo,
      'REPRES_CODE': represCode,
      'RES_TYPE': resType,
      'AREA_NO': areaNo,
      'PAYMENT_TYPE': paymentType,
      'TAAMED_NO': taamedNo,
      'TAAMED_DATE': taamedDate,
      'LAST_DATE': lastDate,
      'GUAR_PRIMARY': guarPrimary,
      'GUAR_FINAL': guarFinal,
      'DELIVERY_PERIOD': deliveryPeriod,
      'LIST_PERIOD': listPeriod,
      'BEG_DATE': begDate,
      'END_DATE': endDate,
      'RECEIVE_PLACE': receivePlace,
      'NOTES': notes,
      'TERMS': terms,
      'TOTAL': total,
      'CUSTOMERNAME': customerName,
      'REPRES_NAME': represName,
      'AREA_NAME': areaName,
    };
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

    final List<dynamic> items = decoded[1];

    return items.map((e) => OfferModel.fromJson(e)).toList();
  }
}
