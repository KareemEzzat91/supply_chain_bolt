import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/features/auth/data/repo/auth_repo.dart';
import 'manager_auth_state.dart';

class ManagerAuthCubit extends Cubit<ManagerAuthState> {
  final AuthRepo authRepo;

  ManagerAuthCubit(this.authRepo) : super(ManagerAuthInitial());


  Future<void> managerLogin(String email, String password) async {
    emit(ManagerAuthLoading());
    try {
      final response = await authRepo.loginAsManager(email, password);
      response.when(
        onSuccess: (data) => emit(ManagerAuthSuccess()),
        onError: (error) => emit(ManagerAuthError("Check your email or password")),
      );
    } catch (e) {
      emit(ManagerAuthError(e.toString()));
    }
  }

  Future<void> managerSignUp(String name ,String email, String password,String role ) async {
    emit(ManagerAuthLoading());
    try {
      final response = await authRepo.registerAsManger(name ,email, password,role);



      response.when(
        onSuccess: (data) => emit(ManagerAuthSuccess()),
        onError: (error) => emit(ManagerAuthError("email already exists")),
      );
    } catch (e) {
      emit(ManagerAuthError(e.toString()));
    }
  }
}
