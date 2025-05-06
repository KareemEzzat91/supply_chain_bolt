abstract class ManagerAuthState {}

class ManagerAuthInitial extends ManagerAuthState {}

class ManagerAuthLoading extends ManagerAuthState {}

class ManagerAuthSuccess extends ManagerAuthState {}

class ManagerAuthError extends ManagerAuthState {
  final String message;
  ManagerAuthError(this.message);
}
