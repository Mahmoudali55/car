import 'package:equatable/equatable.dart';

class AddLoanApplicationResponseModel extends Equatable {
  final bool success;
  final String applicationId;
  final String msg;
  final int uploadedFilesCount;

  const AddLoanApplicationResponseModel({
    required this.success,
    required this.applicationId,
    required this.msg,
    required this.uploadedFilesCount,
  });

  factory AddLoanApplicationResponseModel.fromJson(Map<String, dynamic> json) {
    return AddLoanApplicationResponseModel(
      success: json['success'] ?? false,
      applicationId: json['ApplicationID']?.toString() ?? '',
      msg: json['msg'] ?? '',
      uploadedFilesCount: json['uploadedFilesCount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "ApplicationID": applicationId,
      "msg": msg,
      "uploadedFilesCount": uploadedFilesCount,
    };
  }

  @override
  List<Object?> get props => [success, applicationId, msg, uploadedFilesCount];
}
