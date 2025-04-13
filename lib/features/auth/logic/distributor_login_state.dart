abstract class DistributorLoginState {}

class DistributorLoginInitial extends DistributorLoginState {}

class DistributorLoginLoading extends DistributorLoginState {}

class DistributorLoginSuccess extends DistributorLoginState {}

class DistributorLoginError extends DistributorLoginState {
  final String message;
  DistributorLoginError(this.message);
}
