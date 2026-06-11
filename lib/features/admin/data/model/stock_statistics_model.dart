import 'dart:convert';

import 'package:equatable/equatable.dart';

class StockStatisticsModel extends Equatable {
  final int avaliable;
  final int reserved;
  final int sold;
  final int returnSupplier;

  const StockStatisticsModel({
    required this.avaliable,
    required this.reserved,
    required this.sold,
    required this.returnSupplier,
  });

  factory StockStatisticsModel.fromJson(Map<String, dynamic> json) {
    return StockStatisticsModel(
      avaliable: json['Avaliable'] ?? 0,
      reserved: json['Reserved'] ?? 0,
      sold: json['Sold'] ?? 0,
      returnSupplier: json['Return_supplier'] ?? 0,
    );
  }

  static List<StockStatisticsModel> listFromResponse(dynamic data) {
    final List<dynamic> decoded = data is String ? jsonDecode(data) : data;

    return decoded.map((e) => StockStatisticsModel.fromJson(e)).toList();
  }

  @override
  List<Object?> get props => [avaliable, reserved, sold, returnSupplier];
}
