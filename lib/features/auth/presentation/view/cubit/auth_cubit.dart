import 'package:bloc/bloc.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/network/status.state.dart';
import 'package:car/features/auth/data/model/login_request_model.dart';
import 'package:car/features/auth/data/model/login_response_model.dart';
import 'package:car/features/auth/data/repository/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(const AuthState());

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();

  bool rememberMe = false;

  void changeRememberMe() {
    rememberMe = !rememberMe;
    emit(state.copyWith());
  }

  Future<void> login() async {
    emit(state.copyWith(loginStatus: const StatusState.loading()));

    final request = LoginRequest(
      username: mobileController.text.trim(),
      password: passwordController.text.trim(),
      grantType: 'password',
    );

    final result = await authRepo.login(request: request);

    result.fold(
      (failure) {
        emit(state.copyWith(loginStatus: StatusState.failure(failure.errMessage)));
      },
      (response) async {
        HiveMethods.updateIsGuest(false);
        HiveMethods.updateToken(response.accessToken);
        HiveMethods.updateRole(response.type);
        emit(state.copyWith(loginStatus: StatusState.success(response)));
      },
    );
  }

  Future<void> logout() async {
    await authRepo.logout();
    HiveMethods.updateIsGuest(true);
    HiveMethods.deleteToken();
    HiveMethods.updateRole('user');
    emit(const AuthState()); // reset state
  }
}
