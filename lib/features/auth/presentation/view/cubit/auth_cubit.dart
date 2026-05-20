import 'package:bloc/bloc.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/network/status.state.dart';
import 'package:car/features/auth/data/model/login_request_model.dart';
import 'package:car/features/auth/data/model/login_response_model.dart';
import 'package:car/features/auth/data/model/register_request_model.dart';
import 'package:car/features/auth/data/model/register_response_model.dart';
import 'package:car/features/auth/data/repository/auth_repo.dart';
import 'package:car/core/services/notification_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(const AuthState());

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();
  
  // Registration specific controllers
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController idNoController = TextEditingController();

  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
        HiveMethods.updateUserName(response.userName);
        emit(state.copyWith(loginStatus: StatusState.success(response)));
      },
    );
  }

  Future<void> register() async {
    emit(state.copyWith(registerStatus: const StatusState.loading()));

    // Get FCM token, or default to an empty string if it fails
    String fcmToken = await NotificationService.getFCMToken() ?? '';

    final request = RegisterRequestModel(
      userName: fullNameController.text.trim(),
      email: emailController.text.trim(),
      idno: idNoController.text.trim(),
      password: passwordController.text.trim(),
      fcm: fcmToken,
    );

    final result = await authRepo.register(request: request);

    result.fold(
      (failure) {
        emit(state.copyWith(registerStatus: StatusState.failure(failure.errMessage)));
      },
      (response) async {
        if (response.data) {
          // Clear controllers so the password and data don't persist in the login screen
          fullNameController.clear();
          emailController.clear();
          idNoController.clear();
          passwordController.clear();
          
          emit(state.copyWith(registerStatus: StatusState.success(response)));
        } else {
          emit(state.copyWith(registerStatus: const StatusState.failure('Registration failed')));
        }
      },
    );
  }

  Future<void> changePassword() async {
    emit(state.copyWith(changePasswordStatus: const StatusState.loading()));

    // For now, simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // Check if new password matches confirm password
    if (newPasswordController.text != confirmPasswordController.text) {
      emit(state.copyWith(changePasswordStatus: StatusState.failure('Passwords do not match')));
      return;
    }

    // Simulate success
    emit(state.copyWith(changePasswordStatus: const StatusState.success(true)));

    // Clear controllers
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();
  }

  Future<void> logout() async {
    await authRepo.logout();
    HiveMethods.updateIsGuest(true);
    HiveMethods.deleteToken();
    HiveMethods.updateRole('user');
    HiveMethods.updateUserName('');
    emit(const AuthState()); // reset state
  }
}
