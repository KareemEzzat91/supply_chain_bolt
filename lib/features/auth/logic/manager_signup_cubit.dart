import 'package:flutter_bloc/flutter_bloc.dart';
import 'manager_signup_state.dart';

class ManagerSignupCubit extends Cubit<ManagerSignupState> {
  ManagerSignupCubit() : super(ManagerSignupInitial());

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
