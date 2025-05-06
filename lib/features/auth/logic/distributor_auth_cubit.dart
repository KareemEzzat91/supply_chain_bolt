import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/auth_repo.dart';
import 'distributor_auth_state.dart';

class DistributorAuthCubit extends Cubit<DistributorAuthState> {
  final AuthRepo authRepo;

  DistributorAuthCubit(this.authRepo) : super(DistributorAuthInitial());


  Future<void> distLogin(String email, String password) async {

    emit(DistributorAuthLoading());
    try {
      final response = await authRepo.loginAsDistributor(email, password);
      response.when(
        onSuccess: (data) => emit(DistributorAuthSuccess()),
        onError: (error) => emit(DistributorAuthError("Check your email or password")),
      );
    } catch (e) {
      emit(DistributorAuthError(e.toString()));
    }
  }

  Future<void> distSignUp(String name ,String email, String password,String role ) async {
    emit(DistributorAuthLoading());
    try {
      final response = await authRepo.registerAsDistributor(name ,email, password,role );


      response.when(
        onSuccess: (data) => emit(DistributorAuthSuccess()),
        onError: (error) => emit(DistributorAuthError("email already exists")),
      );

    } catch (e) {
      emit(DistributorAuthError(e.toString()));
    }
  }

}
