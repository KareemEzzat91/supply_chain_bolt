import 'package:flutter_bloc/flutter_bloc.dart';
import 'distributor_signup_state.dart';

class DistributorSignupCubit extends Cubit<DistributorSignupState> {
  DistributorSignupCubit() : super(DistributorSignupInitial());

  Future<void> signup(String name, String email, String password) async {
    emit(DistributorSignupLoading());
    try {
      // TODO: Implement actual signup logic with API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(DistributorSignupSuccess());
    } catch (e) {
      emit(DistributorSignupError(e.toString()));
    }
  }
}
