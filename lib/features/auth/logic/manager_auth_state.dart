abstract class ManagerAuthState {}

class ManagerSignupInitial extends ManagerAuthState {}

class ManagerSignupLoading extends ManagerAuthState {}

class ManagerSignupSuccess extends ManagerAuthState {}

class ManagerSignupError extends ManagerAuthState {
  final String message;
  ManagerSignupError(this.message);
}
