import 'package:equatable/equatable.dart';

class CancelReservedCarResponseModel extends Equatable {
  final bool success;
  final String msg;
  const CancelReservedCarResponseModel({required this.success, required this.msg});
  factory CancelReservedCarResponseModel.fromJson(Map<String, dynamic> json) {
    return CancelReservedCarResponseModel(
      success: json['success'] ?? false,
      msg: json['msg']?.toString() ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {'success': success, 'msg': msg};
  }

  CancelReservedCarResponseModel copyWith({bool? success, String? msg}) {
    return CancelReservedCarResponseModel(success: success ?? this.success, msg: msg ?? this.msg);
  }

  @override
  List<Object?> get props => [success, msg];
}
