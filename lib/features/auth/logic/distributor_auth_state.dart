abstract class DistributorAuthState {}

class DistributorLoginInitial extends DistributorAuthState {}

class DistributorLoginLoading extends DistributorAuthState {}

class DistributorLoginSuccess extends DistributorAuthState {}

class DistributorLoginError extends DistributorAuthState {
  final String message;
  DistributorLoginError(this.message);
}
