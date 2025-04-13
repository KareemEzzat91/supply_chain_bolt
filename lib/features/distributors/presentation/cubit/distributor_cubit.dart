import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/features/distributors/data/models/distributor_model.dart';

import 'distributor_state.dart';


class DistributorCubit extends Cubit<DistributorState> {
  DistributorCubit() : super(DistributorInitial());

  List<DistributorModel> distributors = [];

  Future<void> loadDistributors() async {
    emit(DistributorLoading());
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      distributors = [
        DistributorModel(
          id: '1',
          fullName: 'Moamen Abdelkader',
          phoneNumber: '+20 102 371 0413',
          area: 'ابو النمرس - النزلة',
          email: 'MoamenKader24@gmail.com',
          status: 'Active',
          rating: 4.5,
          completedOrders: 120,
          joinDate: DateTime.now().subtract(const Duration(days: 180)),
          averageDeliveryTime: 45.5,
        ),
        DistributorModel(
          id: '2',
          fullName: 'Mohammed Ali',
          phoneNumber: '+20 101 748 0870',
          area: 'بني سويف - الواسطى ',
          email: 'moali21@gmail.com',
          status: 'Active',
          rating: 4.9,
          completedOrders: 95,
          joinDate: DateTime.now().subtract(const Duration(days: 120)),
          averageDeliveryTime: 38.2,
        ),
      ];
      emit(DistributorLoaded(distributors));
    } catch (e) {
      emit(DistributorError(e.toString()));
    }
  }

  Future<void> addDistributor(DistributorModel distributor) async {
    emit(DistributorLoading());
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      distributors.add(distributor);
      emit(DistributorLoaded(distributors));
    } catch (e) {
      emit(DistributorError(e.toString()));
    }
  }

  Future<void> updateDistributor(DistributorModel distributor) async {
    emit(DistributorLoading());
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      final index = distributors.indexWhere((d) => d.id == distributor.id);
      if (index != -1) {
        distributors[index] = distributor;
        emit(DistributorLoaded(distributors));
      }
    } catch (e) {
      emit(DistributorError(e.toString()));
    }
  }

  Future<void> blockDistributor(String distributorId) async {
    emit(DistributorLoading());
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      final index = distributors.indexWhere((d) => d.id == distributorId);
      if (index != -1) {
        distributors[index] = distributors[index].copyWith(status: 'Blocked');
        emit(DistributorLoaded(distributors));
      }
    } catch (e) {
      emit(DistributorError(e.toString()));
    }
  }

  Future<void> deleteDistributor(String distributorId) async {
    emit(DistributorLoading());
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      distributors.removeWhere((d) => d.id == distributorId);
      emit(DistributorLoaded(distributors));
    } catch (e) {
      emit(DistributorError(e.toString()));
    }
  }

  Future<void> sendNotification(String distributorId, String message) async {
    emit(DistributorLoading());
    try {
      // TODO: Replace with actual API call
      await Future.delayed(const Duration(seconds: 1));
      emit(DistributorLoaded(distributors));
    } catch (e) {
      emit(DistributorError(e.toString()));
    }
  }
}
