import 'package:car/core/network/status.state.dart';
import 'package:car/features/admin/data/repo/admin_repo.dart';
import 'package:car/features/admin/presentation/cubit/admin_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminRepo adminRepo;
  AdminCubit(this.adminRepo) : super(AdminState());

  Future<void> getCarsCountStatus() async {
    emit(state.copyWith(getCarsCountStatus: const StatusState.loading()));
    final result = await adminRepo.getcarscount();
    result.fold(
      (failure) {
        emit(state.copyWith(getCarsCountStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(getCarsCountStatus: StatusState.success(response)));
      },
    );
  }

  Future<void> getCarsStatus(int carstatus, int? CUSTOMER_NO) async {
    emit(state.copyWith(getCarsStatus: const StatusState.loading()));
    final result = await adminRepo.getCars(carstatus, CUSTOMER_NO);
    result.fold(
      (failure) {
        emit(state.copyWith(getCarsStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(getCarsStatus: StatusState.success(response)));
      },
    );
  }

  Future<void> searchRepresentatives(String? searchVal) async {
    emit(state.copyWith(searchRepresentativesStatus: const StatusState.loading()));
    final result = await adminRepo.searchRepresentatives(searchVal);
    result.fold(
      (failure) {
        emit(state.copyWith(searchRepresentativesStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(searchRepresentativesStatus: StatusState.success(response)));
      },
    );
  }

  Future<void> searchCustomers(String? searchVal) async {
    emit(state.copyWith(searchCustomersStatus: const StatusState.loading()));
    final result = await adminRepo.searchCustomers(searchVal);
    result.fold(
      (failure) {
        emit(state.copyWith(searchCustomersStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(searchCustomersStatus: StatusState.success(response)));
      },
    );
  }

  Future<void> searchSuppliers(String? searchVal) async {
    emit(state.copyWith(searchSuppliersStatus: const StatusState.loading()));
    final result = await adminRepo.searchSuppliers(searchVal);
    result.fold(
      (failure) {
        emit(state.copyWith(searchSuppliersStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(searchSuppliersStatus: StatusState.success(response)));
      },
    );
  }
}
