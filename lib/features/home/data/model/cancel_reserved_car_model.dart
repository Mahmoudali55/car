import 'package:equatable/equatable.dart';

class CancelReservedCarModel extends Equatable {
  final String lpoNo;
  final String itemCode;
  final int storeCode;
  final String notes;
  final int customerNo;
  final int represCode;
  const CancelReservedCarModel({
    required this.lpoNo,
    required this.itemCode,
    required this.storeCode,
    required this.notes,
    required this.customerNo,
    required this.represCode,
  });

  factory CancelReservedCarModel.fromJson(Map<String, dynamic> json) {
    return CancelReservedCarModel(
      lpoNo: json['LPONO']?.toString() ?? '',
      itemCode: json['ITEMCODE']?.toString() ?? '',
      storeCode: json['STORECODE'] ?? 0,
      notes: json['NOTES']?.toString() ?? '',
      customerNo: json['CUSTOMERNO'] ?? 0,
      represCode: json['REPRESCODE'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'LPONO': lpoNo,
      'ITEMCODE': itemCode,
      'STORECODE': storeCode,
      'NOTES': notes,
      'CUSTOMERNO': customerNo,
      'REPRESCODE': represCode,
    };
  }

  CancelReservedCarModel copyWith({
    String? lpoNo,
    String? itemCode,
    int? storeCode,
    String? notes,
    int? customerNo,
    int? represCode,
  }) {
    return CancelReservedCarModel(
      lpoNo: lpoNo ?? this.lpoNo,
      itemCode: itemCode ?? this.itemCode,
      storeCode: storeCode ?? this.storeCode,
      notes: notes ?? this.notes,
      customerNo: customerNo ?? this.customerNo,
      represCode: represCode ?? this.represCode,
    );
  }

  @override
  List<Object?> get props => [lpoNo, itemCode, storeCode, notes, customerNo, represCode];
}
