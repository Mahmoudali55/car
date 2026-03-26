import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:car/core/cache/hive/hive_methods.dart';
import 'package:car/core/network/status.state.dart';
import 'package:car/features/auth/data/repository/auth_repo.dart';

import '../../../data/model/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(const AuthState());

  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController accountTypeController = TextEditingController();

  set mobile(String mobile) => mobileController.text = mobile;
  set password(String password) => passwordController.text = password;
  set accountType(String accountType) =>
      accountTypeController.text = accountType;

  bool rememberMe = false;

  void changeRememberMe() {
    rememberMe = !rememberMe;
    emit(state.copyWith());
  }

  Future<void> login({BuildContext? context}) async {
    emit(state.copyWith(loginStatus: const StatusState.loading()));

    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network

    final role = accountTypeController.text == 'مدير' ? 'admin' : 'user';
    final mockUser = User(
      id: 1,
      firstName: 'تست',
      lastName: 'يوزر',
      email: 'test@example.com',
      mobile: mobileController.text.isNotEmpty ? mobileController.text : '123456789',
      mobileVerifiedAt: '2024-01-01',
      photoProfile: '',
      status: 'active',
      isAvailable: 1,
      createdAt: '2024-01-01',
      role: role,
    );

    final mockResponse = AuthResponseModel(
      user: mockUser,
      token: 'mock_jwt_token_bypass_${DateTime.now().millisecondsSinceEpoch}',
      isExpired: false,
      message: 'تم تسجيل الدخول بنجاح',
    );

    HiveMethods.updateIsGuest(false);
    HiveMethods.updateToken(mockResponse.token);
    HiveMethods.updateRole(mockResponse.user.role);
    emit(state.copyWith(loginStatus: StatusState.success(mockResponse)));
  }

  Future<void> logout() async {
    await authRepo.logout();
    HiveMethods.updateIsGuest(false);
    HiveMethods.deleteToken();
    HiveMethods.updateRole('user');
  }
}
