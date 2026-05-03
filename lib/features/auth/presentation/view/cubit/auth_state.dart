part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final StatusState<LoginResponse> loginStatus;
  final StatusState<bool> changePasswordStatus;

  const AuthState({
    this.loginStatus = const StatusState.initial(),
    this.changePasswordStatus = const StatusState.initial(),
  });

  AuthState copyWith({
    StatusState<LoginResponse>? loginStatus,
    StatusState<bool>? changePasswordStatus,
  }) {
    return AuthState(
      loginStatus: loginStatus ?? this.loginStatus,
      changePasswordStatus: changePasswordStatus ?? this.changePasswordStatus,
    );
  }

  @override
  List<Object?> get props => [loginStatus, changePasswordStatus];
}
