abstract class ManagerSignupState {}

class ManagerSignupInitial extends ManagerSignupState {}

class ManagerSignupLoading extends ManagerSignupState {}

class ManagerSignupSuccess extends ManagerSignupState {}

class ManagerSignupError extends ManagerSignupState {
  final String message;
  ManagerSignupError(this.message);
}
