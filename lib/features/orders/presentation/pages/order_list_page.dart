import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:supply_chain_bolt/features/orders/data/datasources/order_remote_data_source.dart';
import 'package:supply_chain_bolt/features/orders/data/repositories/order_repository.dart';
import '../../../../core/theme/theme_provider.dart';
import '../cubit/order_cubit.dart';
import '../../data/models/order_model.dart';

class OrderListPage extends StatelessWidget {
  const OrderListPage({super.key});

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.processing:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return BlocProvider(
  create: (context) => OrderCubit(OrderRepositoryImpl(OrderRemoteDataSourceImpl(baseUrl: "",dio: Dio()))),
  child: BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Orders'),
            actions: [
              IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              ),
            ],
          ),
          body: _buildBody(state, theme),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // TODO: Create new order
            },
            backgroundColor: theme.primaryColor,
            child: const Icon(Icons.add),
          ),
        );
      },
    ),
);
  }

  Widget _buildBody(OrderState state, ThemeData theme) {
/*
    if (state is OrderInitial || state is OrderLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is OrderError) {
      return Center(
        child: Text(
          state.message,
          style: theme.textTheme.bodyLarge?.copyWith(color: Colors.red),
        ),
      );
    }
*/

/*    if (state is OrderLoaded) {
      final orders = state.orders;
      if (orders.isEmpty) {
        return Center(
          child: Text(
            'No orders found',
            style: theme.textTheme.bodyLarge,
          ),
        );
      }*/
    final orders = [
      OrderModel(id: "1", customerName: "Ahmed", customerEmail: "kareem@gmail.com", customerPhone: "01004092979", shippingAddress: "22 Id egg st", items: [], status: OrderStatus.pending, createdAt: DateTime(DateTime.april), updatedAt: DateTime(DateTime.friday))
    ];


    return ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Container(
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/order-details',
                    arguments: {'orderId': order.id},
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order #${order.id}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(order.status),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              order.status.toString().split('.').last,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                order.customerName,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                '${order.items.length} items',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$${order.totalAmount.toStringAsFixed(2)}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
  /*  }*/

    return const SizedBox.shrink();
  }
}
