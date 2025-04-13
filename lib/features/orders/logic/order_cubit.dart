import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/features/orders/data/models/order_model.dart';
import 'package:supply_chain_bolt/features/orders/data/repositories/order_repository.dart';
import 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _repository;

  OrderCubit(this._repository) : super(OrderInitial());

  Future<void> getOrders() async {
    emit(OrderLoading());
    try {
      final orders = await _repository.getOrders();
      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> createOrder(OrderModel order) async {
    emit(OrderLoading());
    try {
      final createdOrder = await _repository.createOrder(order);
      emit(OrderCreated(createdOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    emit(OrderLoading());
    try {
      final updatedOrder = await _repository.updateOrder(order);
      emit(OrderUpdated(updatedOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> deleteOrder(String orderId) async {
    emit(OrderLoading());
    try {
      await _repository.deleteOrder(orderId);
      emit(OrderDeleted(orderId));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    emit(OrderLoading());
    try {
      final updatedOrder = await _repository.updateOrderStatus(orderId, status);
      emit(OrderUpdated(updatedOrder));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
