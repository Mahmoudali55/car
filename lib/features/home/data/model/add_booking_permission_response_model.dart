import 'package:equatable/equatable.dart';

class AddBookingPermissionResponseModel extends Equatable {
  final bool success;
  final String lpoNo;
  final String msg;

  const AddBookingPermissionResponseModel({
    required this.success,
    required this.lpoNo,
    required this.msg,
  });

  factory AddBookingPermissionResponseModel.fromJson(Map<String, dynamic> json) {
    return AddBookingPermissionResponseModel(
      success: json['success'] ?? false,
      lpoNo: json['lpono'] ?? '',
      msg: json['msg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"success": success, "lpono": lpoNo, "msg": msg};
  }

  AddBookingPermissionResponseModel copyWith({bool? success, String? lpoNo, String? msg}) {
    return AddBookingPermissionResponseModel(
      success: success ?? this.success,
      lpoNo: lpoNo ?? this.lpoNo,
      msg: msg ?? this.msg,
    );
  }

  @override
  List<Object?> get props => [success, lpoNo, msg];
}
