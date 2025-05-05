import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/auth_repo.dart';
import 'distributor_auth_state.dart';

class DistributorAuthCubit extends Cubit<DistributorAuthState> {
  final AuthRepo authRepo;

  DistributorAuthCubit(this.authRepo) : super(DistributorLoginInitial());


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

  Future<void> distSignUp(String email, String password,String role ) async {
    emit(DistributorLoginLoading());
    try {
      // TODO: Implement actual login logic with API
      authRepo.registerAsDistributor(email, password,role);
      emit(DistributorLoginSuccess());
    } catch (e) {
      emit(DistributorLoginError(e.toString()));
    }
  }

}
