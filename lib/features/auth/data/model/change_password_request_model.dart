import 'package:equatable/equatable.dart';

class ChangePasswordRequestModel extends Equatable {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "OldPassword": oldPassword,
      "NewPassword": newPassword,
      "ConfirmPassword": confirmPassword,
    };
  }

  @override
  List<Object?> get props => [oldPassword, newPassword, confirmPassword];
}
