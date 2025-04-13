abstract class DistributorSignupState {}

class DistributorSignupInitial extends DistributorSignupState {}

class DistributorSignupLoading extends DistributorSignupState {}

class DistributorSignupSuccess extends DistributorSignupState {}

class DistributorSignupError extends DistributorSignupState {
  final String message;
  DistributorSignupError(this.message);
}
