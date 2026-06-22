import 'package:car/core/network/status.state.dart';
import 'package:car/features/agent/data/repo/agent_repo.dart';
import 'package:car/features/agent/presentation/cubit/agent_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AgentCubit extends Cubit<AgentState> {
  final AgentRepo agentRepo;

  AgentCubit(this.agentRepo) : super(const AgentState());
  Future<void> getCustomer(String? Searchval) async {
    emit(state.copyWith(customersStatus: const StatusState.loading()));
    final result = await agentRepo.getCustomer(Searchval);
    result.fold(
      (failure) {
        emit(state.copyWith(customersStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(customersStatus: StatusState.success(response)));
      },
    );
  }

  Future<void> getOffers(String? Searchval, int REPRESNO, int? LISTNO) async {
    emit(state.copyWith(offersStatus: const StatusState.loading()));
    final result = await agentRepo.getOffers(Searchval, REPRESNO, LISTNO);
    result.fold(
      (failure) {
        emit(state.copyWith(offersStatus: StatusState.failure(failure.errMessage)));
      },
      (response) {
        emit(state.copyWith(offersStatus: StatusState.success(response)));
      },
    );
  }
}
