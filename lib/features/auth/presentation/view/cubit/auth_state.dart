part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final StatusState<LoginResponse> loginStatus;
  final StatusState<RegisterResponseModel> registerStatus;
  final StatusState<bool> changePasswordStatus;

  const AuthState({
    this.loginStatus = const StatusState.initial(),
    this.registerStatus = const StatusState.initial(),
    this.changePasswordStatus = const StatusState.initial(),
  });

  AuthState copyWith({
    StatusState<LoginResponse>? loginStatus,
    StatusState<RegisterResponseModel>? registerStatus,
    StatusState<bool>? changePasswordStatus,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      registerStatus: registerStatus ?? this.registerStatus,
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
    );
  }

  @override
  List<Object?> get props => [loginStatus, registerStatus, changePasswordStatus];
}
