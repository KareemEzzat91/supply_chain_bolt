import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/features/auth/data/repo/auth_repo.dart';
import 'manager_auth_state.dart';

class ManagerAuthCubit extends Cubit<ManagerAuthState> {
  final AuthRepo authRepo;

  ManagerAuthCubit(this.authRepo) : super(ManagerSignupInitial());

  Future<void> signup(String name, String email, String password) async {
    emit(ManagerSignupLoading());
    try {
      // TODO: Implement actual signup logic with API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(ManagerSignupSuccess());
    } catch (e) {
      emit(ManagerSignupError(e.toString()));
    }
  }
}
