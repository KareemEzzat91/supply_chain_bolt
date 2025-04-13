import 'package:flutter_bloc/flutter_bloc.dart';
import 'distributor_login_state.dart';

class DistributorLoginCubit extends Cubit<DistributorLoginState> {
  DistributorLoginCubit() : super(DistributorLoginInitial());

  Future<void> login(String email, String password) async {
    emit(DistributorLoginLoading());
    try {
      // TODO: Implement actual login logic with API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(DistributorLoginSuccess());
    } catch (e) {
      emit(DistributorLoginError(e.toString()));
    }
  }
}
