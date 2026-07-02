import 'package:equatable/equatable.dart';

class CancelReservedCarModel extends Equatable {
  final String lpoNo;
  final String itemCode;
  final int storeCode;
  final String notes;

  const CancelReservedCarModel({
    required this.lpoNo,
    required this.itemCode,
    required this.storeCode,
    required this.notes,
  });

  factory CancelReservedCarModel.fromJson(Map<String, dynamic> json) {
    return CancelReservedCarModel(
      lpoNo: json['LPONO']?.toString() ?? '',
      itemCode: json['ITEMCODE']?.toString() ?? '',
      storeCode: json['STORECODE'] ?? 0,
      notes: json['NOTES']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'LPONO': lpoNo, 'ITEMCODE': itemCode, 'STORECODE': storeCode, 'NOTES': notes};
  }

  CancelReservedCarModel copyWith({
    String? lpoNo,
    String? itemCode,
    int? storeCode,
    String? notes,
  }) {
    return CancelReservedCarModel(
      lpoNo: lpoNo ?? this.lpoNo,
      itemCode: itemCode ?? this.itemCode,
      storeCode: storeCode ?? this.storeCode,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [lpoNo, itemCode, storeCode, notes];
}
