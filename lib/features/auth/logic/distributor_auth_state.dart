abstract class DistributorAuthState {}

class DistributorAuthInitial extends DistributorAuthState {}

class DistributorAuthLoading extends DistributorAuthState {}

class DistributorAuthSuccess extends DistributorAuthState {}

class DistributorAuthError extends DistributorAuthState {
  final String message;
  DistributorAuthError(this.message);
}
