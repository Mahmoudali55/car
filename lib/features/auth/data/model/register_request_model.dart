import 'package:equatable/equatable.dart';

class RegisterRequestModel extends Equatable {
  final String userName;
  final String email;
  final String idno;
  final String password;
  final String fcm;
  final String fullname;

  const RegisterRequestModel({
    required this.userName,
    required this.email,
    required this.idno,
    required this.password,
    required this.fcm,
    required this.fullname,
  });

  Map<String, dynamic> toJson() {
    return {
      'UserName': userName,
      'Email': email,
      'IDNO': idno,
      'password': password,
      'FCM': fcm,
      'FullName': fullname,
    };
  }

  @override
  List<Object?> get props => [userName, email, idno, password, fcm, fullname];
}
