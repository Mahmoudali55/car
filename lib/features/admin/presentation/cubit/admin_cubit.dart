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
}
