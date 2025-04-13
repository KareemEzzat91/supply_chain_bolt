import 'package:dio/dio.dart';
import 'package:supply_chain_bolt/features/orders/data/models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> getOrders();
  Future<OrderModel> createOrder(OrderModel order);
  Future<OrderModel> updateOrder(OrderModel order);
  Future<void> deleteOrder(String orderId);
  Future<OrderModel> updateOrderStatus(String orderId, OrderStatus status);
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;
  final String baseUrl;

  OrderRemoteDataSourceImpl({
    required this.dio,
    required this.baseUrl,
  });

  @override
  Future<List<OrderModel>> getOrders() async {
    try {
      final response = await dio.get('$baseUrl/orders');
      return (response.data as List)
          .map((json) => OrderModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to get orders: $e');
    }
  }

  @override
  Future<OrderModel> createOrder(OrderModel order) async {
    try {
      final response = await dio.post(
        '$baseUrl/orders',
        data: order.toJson(),
      );
      return OrderModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create order: $e');
    }
  }

  @override
  Future<OrderModel> updateOrder(OrderModel order) async {
    try {
      final response = await dio.put(
        '$baseUrl/orders/${order.id}',
        data: order.toJson(),
      );
      return OrderModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update order: $e');
    }
  }

  @override
  Future<void> deleteOrder(String orderId) async {
    try {
      await dio.delete('$baseUrl/orders/$orderId');
    } catch (e) {
      throw Exception('Failed to delete order: $e');
    }
  }

  @override
  Future<OrderModel> updateOrderStatus(
      String orderId, OrderStatus status) async {
    try {
      final response = await dio.patch(
        '$baseUrl/orders/$orderId/status',
        data: {'status': status.toString().split('.').last},
      );
      return OrderModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }
}
