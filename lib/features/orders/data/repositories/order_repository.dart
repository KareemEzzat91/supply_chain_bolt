import 'package:supply_chain_bolt/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:supply_chain_bolt/features/orders/data/models/order_model.dart';

abstract class OrderRepository {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> createOrder(OrderModel order);
  Future<OrderModel> updateOrder(OrderModel order);
  Future<void> deleteOrder(String orderId);
  Future<OrderModel> updateOrderStatus(String orderId, OrderStatus status);
}

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource _remoteDataSource;

  OrderRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<OrderModel>> getOrders() async {
    return _remoteDataSource.getOrders();
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    return _remoteDataSource.createOrder(order);
  }

  @override
  Future<OrderModel> updateOrder(OrderModel order) async {
    return _remoteDataSource.updateOrder(order);
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    return _remoteDataSource.deleteOrder(orderId);
  }

  @override
  Future<OrderModel> updateOrderStatus(
      String orderId, OrderStatus status) async {
    return _remoteDataSource.updateOrderStatus(orderId, status);
  }
}
