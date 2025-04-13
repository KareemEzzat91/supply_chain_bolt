import 'package:supply_chain_bolt/features/orders/data/models/order_model.dart';

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

class OrderCreated extends OrderState {
  final OrderModel order;
  OrderCreated(this.order);
}

class OrderUpdated extends OrderState {
  final OrderModel order;
  OrderUpdated(this.order);
}

class OrderDeleted extends OrderState {
  final String orderId;
  OrderDeleted(this.orderId);
}
