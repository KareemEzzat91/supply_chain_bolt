/*
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/api_helper/api_helper.dart';
import 'package:supply_chain_bolt/features/auth/repo/auth_repo.dart';
import 'distributor_login_state.dart';

class DistributorLoginCubit extends Cubit<DistributorLoginState> {
  final AuthRepo authRepo;

  DistributorLoginCubit(this.authRepo) : super(DistributorLoginInitial());


  Future<void> distLogin(String email, String password) async {
    emit(DistributorLoginLoading());
    try {
      // TODO: Implement actual login logic with API
      authRepo.loginAsDistributor(email, password);
      emit(DistributorLoginSuccess());
    } catch (e) {
      emit(DistributorLoginError(e.toString()));
    }
  }

  Future<void> mangerLogin(String email, String password) async {
    emit(DistributorLoginLoading());
    try {
      // TODO: Implement actual login logic with API
      authRepo.loginAsManager(email, password);
      emit(DistributorLoginSuccess());
    } catch (e) {
      emit(DistributorLoginError(e.toString()));
    }
  }
  Future<void> distSignUp(String email, String password) async {
    emit(DistributorLoginLoading());
    try {
      // TODO: Implement actual login logic with API
      authRepo.registerAsDistributor(email, password);
      emit(DistributorLoginSuccess());
    } catch (e) {
      emit(DistributorLoginError(e.toString()));
    }
  }
  Future<void> mangerSignUp(String email, String password) async {
    emit(DistributorLoginLoading());
    try {
      // TODO: Implement actual login logic with API
      authRepo.registerAsManger(email, password);
      emit(DistributorLoginSuccess());
    } catch (e) {
      emit(DistributorLoginError(e.toString()));
    }
  }

}
*/
