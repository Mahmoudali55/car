import 'package:equatable/equatable.dart';

class RegisterRequestModel extends Equatable {
  final String userName;
  final String email;
  final String idno;
  final String password;
  final String fcm;

  const RegisterRequestModel({
    required this.userName,
    required this.email,
    required this.idno,
    required this.password,
    required this.fcm,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Email': email,
      'IDNO': idno,
      'password': password,
      'FCM': fcm,
    };
  }

  @override
  List<Object?> get props => [userName, email, idno, password, fcm];
}
