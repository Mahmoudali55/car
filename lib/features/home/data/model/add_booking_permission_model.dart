import 'package:equatable/equatable.dart';

class AddBookingPermissionModel extends Equatable {
  final String lpoNos;
  final String lpono;
  final int listNo;
  final String analytical;
  final int customerNo;
  final int represCode;
  final String fDate;
  final String lDate;
  final String lpoDate;
  final int storeCode;
  final String taamedNo;
  final String payCond;
  final int guarFinal;
  final String notes;
  final String userName;
  final List<SubLpoModel> subLpo;

  const AddBookingPermissionModel({
    required this.lpoNos,
    required this.lpono,
    required this.listNo,
    required this.analytical,
    required this.customerNo,
    required this.represCode,
    required this.fDate,
    required this.lDate,
    required this.lpoDate,
    required this.storeCode,
    required this.taamedNo,
    required this.payCond,
    required this.guarFinal,
    required this.notes,
    required this.subLpo,
    required this.userName,
  });

  factory AddBookingPermissionModel.fromJson(Map<String, dynamic> json) {
    return AddBookingPermissionModel(
      lpoNos: json['LPONOs'] ?? '',
      lpono: json['LPONO'] ?? '',
      listNo: json['LISTNO'] ?? 0,
      analytical: json['ANALYTICAL'] ?? '',
      customerNo: json['CUSTOMERNO'] ?? 0,
      represCode: json['REPRESCODE'] ?? 0,
      fDate: json['RESERVBEGIN'] ?? '',
      lDate: json['RESERVEND'] ?? '',
      lpoDate: json['LPODATE'] ?? '',
      storeCode: json['STORECODE'] ?? 0,
      taamedNo: json['TAAMEDNO'] ?? '',
      payCond: json['PAYCOND'] ?? '',
      guarFinal: json['GUARFINAL'] ?? 0,
      notes: json['NOTES'] ?? '',
      userName: json['username'] ?? '',
      subLpo:
          (json['sub_lpo'] as List<dynamic>?)?.map((e) => SubLpoModel.fromJson(e)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "LPONOs": lpoNos,
      "LPONO": lpono,
      "LISTNO": listNo,
      "ANALYTICAL": analytical,
      "CUSTOMERNO": customerNo,
      "REPRESCODE": represCode,
      "RESERVBEGIN": fDate,
      "RESERVEND": lDate,
      "LPODATE": lpoDate,
      "STORECODE": storeCode,
      "TAAMEDNO": taamedNo,
      "PAYCOND": payCond,
      "GUARFINAL": guarFinal,
      "NOTES": notes,
      "sub_lpo": subLpo.map((e) => e.toJson()).toList(),
      "username": userName,
    };
  }

  AddBookingPermissionModel copyWith({
    String? lpoNos,
    String? lpono,
    int? listNo,
    String? analytical,
    int? customerNo,
    int? represCode,
    String? fDate,
    String? lDate,
    String? lpoDate,
    int? storeCode,
    String? taamedNo,
    String? payCond,
    int? guarFinal,
    String? notes,
    List<SubLpoModel>? subLpo,
    String? userName,
  }) {
    return AddBookingPermissionModel(
      lpoNos: lpoNos ?? this.lpoNos,
      lpono: lpono ?? this.lpono,
      listNo: listNo ?? this.listNo,
      analytical: analytical ?? this.analytical,
      customerNo: customerNo ?? this.customerNo,
      represCode: represCode ?? this.represCode,
      fDate: fDate ?? this.fDate,
      lDate: lDate ?? this.lDate,
      lpoDate: lpoDate ?? this.lpoDate,
      storeCode: storeCode ?? this.storeCode,
      taamedNo: taamedNo ?? this.taamedNo,
      payCond: payCond ?? this.payCond,
      guarFinal: guarFinal ?? this.guarFinal,
      notes: notes ?? this.notes,
      subLpo: subLpo ?? this.subLpo,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [
    lpoNos,
    lpono,
    listNo,
    analytical,
    customerNo,
    represCode,
    fDate,
    lDate,
    lpoDate,
    storeCode,
    taamedNo,
    payCond,
    guarFinal,
    notes,
    subLpo,
    userName,
  ];
}

class SubLpoModel extends Equatable {
  final String itemCode;
  final String itemName;
  final String chassisNo;
  final double price;
  final double advancedAmount;
  final String lpoNo;
  final int lpoType;
  final int storeCode;
  final String transDate;

  final String userName;
  const SubLpoModel({
    required this.itemCode,
    required this.itemName,
    required this.chassisNo,
    required this.price,
    required this.advancedAmount,
    required this.lpoNo,
    required this.lpoType,
    required this.storeCode,
    required this.transDate,

    this.userName = '',
  });

  factory SubLpoModel.fromJson(Map<String, dynamic> json) {
    return SubLpoModel(
      itemCode: json['ITEM_CODE'] ?? '',
      itemName: json['ITEM_NAME'] ?? '',
      chassisNo: json['CHASSIS_NO'] ?? '',
      price: (json['PRICE'] ?? 0).toDouble(),
      advancedAmount: (json['ADVANCED_AMOUNT'] ?? 0).toDouble(),
      lpoNo: json['LPO_NO'] ?? '',
      lpoType: json['LPO_TYPE'] ?? 0,
      storeCode: json['STORE_CODE'] ?? 0,
      transDate: json['TRANSDATE'] ?? '',

      userName: json['username'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ITEM_CODE": itemCode,
      "ITEM_NAME": itemName,
      "CHASSIS_NO": chassisNo,
      "PRICE": price,
      "ADVANCED_AMOUNT": advancedAmount,
      "LPO_NO": lpoNo,
      "LPO_TYPE": lpoType,
      "STORE_CODE": storeCode,
      "TRANSDATE": transDate,
      "username": userName,
    };
  }

  SubLpoModel copyWith({
    String? itemCode,
    String? itemName,
    String? chassisNo,
    double? price,
    double? advancedAmount,
    String? lpoNo,
    int? lpoType,
    int? storeCode,
    String? transDate,
    String? fDate,
    String? lDate,
    String? userName,
  }) {
    return SubLpoModel(
      itemCode: itemCode ?? this.itemCode,
      itemName: itemName ?? this.itemName,
      chassisNo: chassisNo ?? this.chassisNo,
      price: price ?? this.price,
      advancedAmount: advancedAmount ?? this.advancedAmount,
      lpoNo: lpoNo ?? this.lpoNo,
      lpoType: lpoType ?? this.lpoType,
      storeCode: storeCode ?? this.storeCode,
      transDate: transDate ?? this.transDate,

      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object?> get props => [
    itemCode,
    itemName,
    chassisNo,
    price,
    advancedAmount,
    lpoNo,
    lpoType,
    storeCode,
    transDate,
    userName,
  ];
}
