import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerLoginCubit extends Cubit<ManagerLoginState> {
  ManagerLoginCubit() : super(ManagerLoginInitial());

  Future<void> login(String email, String password) async {
    emit(ManagerLoginLoading());
    try {
      // TODO: Implement actual login logic with API
      await Future.delayed(const Duration(seconds: 2)); // Simulate API call
      emit(ManagerLoginSuccess());
    } catch (e) {
      emit(ManagerLoginError(e.toString()));
    }
  }
}

abstract class ManagerLoginState {}

class ManagerLoginInitial extends ManagerLoginState {}

class ManagerLoginLoading extends ManagerLoginState {}

class ManagerLoginSuccess extends ManagerLoginState {}

class ManagerLoginError extends ManagerLoginState {
  final String message;
  ManagerLoginError(this.message);
}
