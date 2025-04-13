import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/features/orders/data/models/order_model.dart';
import 'package:supply_chain_bolt/features/orders/data/repositories/order_repository.dart';

abstract class OrderState {}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {
  final List<OrderModel> orders;
  OrderLoaded(this.orders);
}

class OrderError extends OrderState {
  final String message;
  OrderError(this.message);
}

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository _repository;

  OrderCubit(this._repository) : super(OrderInitial());

  Future<void> getOrders() async {
    try {
      emit(OrderLoading());
      // Simulate API delay
      await Future.delayed(const Duration(seconds: 1));

      // Fake data
      final orders = [
        OrderModel(
          id: '1',
          customerName: 'John Doe',
          customerEmail: 'john@example.com',
          customerPhone: '+1234567890',
          shippingAddress: '123 Main St, New York, NY 10001',
          items: const [
            OrderItem(
              id: '1',
              name: 'Product A',
              quantity: 2,
              price: 29.99,
            ),
            OrderItem(
              id: '2',
              name: 'Product B',
              quantity: 1,
              price: 49.99,
            ),
          ],
          status: OrderStatus.pending,
          createdAt: DateTime.now().subtract(const Duration(days: 2)),
          updatedAt: DateTime.now(),
        ),
        OrderModel(
          id: '2',
          customerName: 'Jane Smith',
          customerEmail: 'jane@example.com',
          customerPhone: '+1987654321',
          shippingAddress: '456 Oak Ave, Los Angeles, CA 90001',
          items: [
            OrderItem(
              id: '3',
              name: 'Product C',
              quantity: 3,
              price: 19.99,
            ),
          ],
          status: OrderStatus.processing,
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          updatedAt: DateTime.now(),
        ),
        OrderModel(
          id: '3',
          customerName: 'Bob Johnson',
          customerEmail: 'bob@example.com',
          customerPhone: '+1122334455',
          shippingAddress: '789 Pine St, Chicago, IL 60601',
          items: [
            OrderItem(
              id: '4',
              name: 'Product D',
              quantity: 1,
              price: 99.99,
            ),
            OrderItem(
              id: '5',
              name: 'Product E',
              quantity: 2,
              price: 39.99,
            ),
          ],
          status: OrderStatus.completed,
          createdAt: DateTime.now().subtract(const Duration(days: 3)),
          updatedAt: DateTime.now(),
        ),
      ];

      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError('Failed to load orders: ${e.toString()}'));
    }
  }

  Future<void> createOrder(OrderModel order) async {
    try {
      emit(OrderLoading());
      await _repository.createOrder(order);
      await getOrders();
    } catch (e) {
      emit(OrderError('Failed to create order: ${e.toString()}'));
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      emit(OrderLoading());
      await _repository.updateOrder(order);
      await getOrders();
    } catch (e) {
      emit(OrderError('Failed to update order: ${e.toString()}'));
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      emit(OrderLoading());
      await _repository.deleteOrder(orderId);
      await getOrders();
    } catch (e) {
      emit(OrderError('Failed to delete order: ${e.toString()}'));
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    try {
      emit(OrderLoading());
      await _repository.updateOrderStatus(orderId, status);
      await getOrders();
    } catch (e) {
      emit(OrderError('Failed to update order status: ${e.toString()}'));
    }
  }
}
