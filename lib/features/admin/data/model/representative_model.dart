import 'dart:convert';

import 'package:equatable/equatable.dart';

class RepresentativeModel extends Equatable {
  final int? represNo;
  final String? address;
  final String? analytical;
  final int? areaNo;
  final double? comitionPer;
  final String? delingDate;
  final String? fax;
  final double? minLimitSales;
  final String? notes;
  final String? poxOffice;
  final int? represKind;
  final String? areaName;
  final String? typeName;
  final String? represName;
  final String? represNameEng;
  final String? tel1;
  final String? tel2;
  final String? tel3;
  final String? telex;
  final String? tradeName;
  final String? tradeRecord;
  final int? commType;
  final int? discState;
  final String? sambleBox;
  final double? minLimitColl;
  final double? minLimitRev;
  final double? comCollPre;
  final double? comRevPre;
  final double? openingBalanceLoc;
  final double? openingBalance1Loc;
  final double? prvDbLoc;
  final double? prvCdLoc;
  final double? curDbLoc;
  final double? curCdLoc;
  final double? balanceLocal;
  final String? masterRepres;
  final double? delarCriditLimit;
  final double? repR1;
  final double? repR2;
  final int? branchNo;
  final int? convertFlag;
  final int? represType;
  final String? employeeType;

  const RepresentativeModel({
    this.represNo,
    this.address,
    this.analytical,
    this.areaNo,
    this.comitionPer,
    this.delingDate,
    this.fax,
    this.minLimitSales,
    this.notes,
    this.poxOffice,
    this.represKind,
    this.areaName,
    this.typeName,
    this.represName,
    this.represNameEng,
    this.tel1,
    this.tel2,
    this.tel3,
    this.telex,
    this.tradeName,
    this.tradeRecord,
    this.commType,
    this.discState,
    this.sambleBox,
    this.minLimitColl,
    this.minLimitRev,
    this.comCollPre,
    this.comRevPre,
    this.openingBalanceLoc,
    this.openingBalance1Loc,
    this.prvDbLoc,
    this.prvCdLoc,
    this.curDbLoc,
    this.curCdLoc,
    this.balanceLocal,
    this.masterRepres,
    this.delarCriditLimit,
    this.repR1,
    this.repR2,
    this.branchNo,
    this.convertFlag,
    this.represType,
    this.employeeType,
  });

  factory RepresentativeModel.fromJson(Map<String, dynamic> json) {
    return RepresentativeModel(
      represNo: json['REPRES_NO'],
      address: json['ADDRESS'],
      analytical: json['ANALYTICAL'],
      areaNo: json['AREA_NO'],
      comitionPer: (json['COMITION_PER'] as num?)?.toDouble(),
      delingDate: json['DELING_DATE'],
      fax: json['FAX'],
      minLimitSales: (json['MIN_LIMIT_SALES'] as num?)?.toDouble(),
      notes: json['NOTES'],
      poxOffice: json['POX_OFFICE'],
      represKind: json['REPRES_KIND'],
      areaName: json['AREA_NAME'],
      typeName: json['TYPE_NAME'],
      represName: json['REPRES_NAME'],
      represNameEng: json['REPRES_NAME_ENG'],
      tel1: json['TEL1'],
      tel2: json['TEL2'],
      tel3: json['TEL3'],
      telex: json['TELEX'],
      tradeName: json['TRADE_NAME'],
      tradeRecord: json['TRADE_RECORD'],
      commType: json['COMM_TYPE'],
      discState: json['DISC_STATE'],
      sambleBox: json['SAMBLE_BOX'],
      minLimitColl: (json['MIN_LIMIT_COLL'] as num?)?.toDouble(),
      minLimitRev: (json['MIN_LIMIT_REV'] as num?)?.toDouble(),
      comCollPre: (json['COM_COLL_PRE'] as num?)?.toDouble(),
      comRevPre: (json['COM_REV_PRE'] as num?)?.toDouble(),
      openingBalanceLoc: (json['OPENING_BALANCE_LOC'] as num?)?.toDouble(),
      openingBalance1Loc: (json['OPENING_BALANCE1_LOC'] as num?)?.toDouble(),
      prvDbLoc: (json['PRV_DB_LOC'] as num?)?.toDouble(),
      prvCdLoc: (json['PRV_CD_LOC'] as num?)?.toDouble(),
      curDbLoc: (json['CUR_DB_LOC'] as num?)?.toDouble(),
      curCdLoc: (json['CUR_CD_LOC'] as num?)?.toDouble(),
      balanceLocal: (json['BALANCE_LOCAL'] as num?)?.toDouble(),
      masterRepres: json['Master_Repres'],
      delarCriditLimit: (json['DELAR_CRIDIT_LIMIT'] as num?)?.toDouble(),
      repR1: (json['REP_R1'] as num?)?.toDouble(),
      repR2: (json['REP_R2'] as num?)?.toDouble(),
      branchNo: json['BRANCH_NO'],
      convertFlag: json['CONVERTFLAG'],
      represType: json['REPRES_TYPE'],
      employeeType: json['EMPLOYEE_TYPE'],
    );
  }

  static List<RepresentativeModel> listFromResponse(dynamic data) {
    if (data == null) return [];

    dynamic parsedData = data;
    if (parsedData is String) {
      try {
        final decoded = jsonDecode(parsedData);
        parsedData = decoded;
      } catch (_) {
        return [];
      }
    }

    if (parsedData is Map<String, dynamic> && parsedData.containsKey('Data')) {
      parsedData = parsedData['Data'];
    }

    if (parsedData is String) {
      try {
        final decoded = jsonDecode(parsedData);
        parsedData = decoded;
      } catch (_) {
        // If it's a string but not JSON, we can't do much
      }
    }

    if (parsedData is! List) return [];

    return parsedData
        .whereType<Map<String, dynamic>>()
        .map((item) => RepresentativeModel.fromJson(item))
        .toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'REPRES_NO': represNo,
      'ADDRESS': address,
      'ANALYTICAL': analytical,
      'AREA_NO': areaNo,
      'COMITION_PER': comitionPer,
      'DELING_DATE': delingDate,
      'FAX': fax,
      'MIN_LIMIT_SALES': minLimitSales,
      'NOTES': notes,
      'POX_OFFICE': poxOffice,
      'REPRES_KIND': represKind,
      'AREA_NAME': areaName,
      'TYPE_NAME': typeName,
      'REPRES_NAME': represName,
      'REPRES_NAME_ENG': represNameEng,
      'TEL1': tel1,
      'TEL2': tel2,
      'TEL3': tel3,
      'TELEX': telex,
      'TRADE_NAME': tradeName,
      'TRADE_RECORD': tradeRecord,
      'COMM_TYPE': commType,
      'DISC_STATE': discState,
      'SAMBLE_BOX': sambleBox,
      'MIN_LIMIT_COLL': minLimitColl,
      'MIN_LIMIT_REV': minLimitRev,
      'COM_COLL_PRE': comCollPre,
      'COM_REV_PRE': comRevPre,
      'OPENING_BALANCE_LOC': openingBalanceLoc,
      'OPENING_BALANCE1_LOC': openingBalance1Loc,
      'PRV_DB_LOC': prvDbLoc,
      'PRV_CD_LOC': prvCdLoc,
      'CUR_DB_LOC': curDbLoc,
      'CUR_CD_LOC': curCdLoc,
      'BALANCE_LOCAL': balanceLocal,
      'Master_Repres': masterRepres,
      'DELAR_CRIDIT_LIMIT': delarCriditLimit,
      'REP_R1': repR1,
      'REP_R2': repR2,
      'BRANCH_NO': branchNo,
      'CONVERTFLAG': convertFlag,
      'REPRES_TYPE': represType,
      'EMPLOYEE_TYPE': employeeType,
    };
  }

  @override
  List<Object?> get props => [
    represNo,
    address,
    analytical,
    areaNo,
    comitionPer,
    delingDate,
    fax,
    minLimitSales,
    notes,
    poxOffice,
    represKind,
    areaName,
    typeName,
    represName,
    represNameEng,
    tel1,
    tel2,
    tel3,
    telex,
    tradeName,
    tradeRecord,
    commType,
    discState,
    sambleBox,
    minLimitColl,
    minLimitRev,
    comCollPre,
    comRevPre,
    openingBalanceLoc,
    openingBalance1Loc,
    prvDbLoc,
    prvCdLoc,
    curDbLoc,
    curCdLoc,
    balanceLocal,
    masterRepres,
    delarCriditLimit,
    repR1,
    repR2,
    branchNo,
    convertFlag,
    represType,
    employeeType,
  ];
}
