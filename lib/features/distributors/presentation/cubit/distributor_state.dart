import 'package:equatable/equatable.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';

abstract class DistributorState extends Equatable {
  const DistributorState();

  @override
  List<Object?> get props => [];
}

class DistributorInitial extends DistributorState {}

class DistributorLoading extends DistributorState {}

class DistributorLoaded extends DistributorState {
  final List<DistributorModel> distributors;

  const DistributorLoaded(this.distributors);

  @override
  List<Object?> get props => [distributors];
}

class DistributorError extends DistributorState {
  final String message;

  const DistributorError(this.message);

  @override
  List<Object?> get props => [message];
}
