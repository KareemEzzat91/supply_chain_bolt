import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supply_chain_bolt/core/routing/routes.dart';

class ScanSuccessScreen extends StatelessWidget {
  const ScanSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>? ?? <String, dynamic>{};
    final orderId = args['orderId']?.toString() ?? '1'; // or provide a default value

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan Success'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.check_circle,
                size: 100.sp,
                color: Colors.green,
              ),
              SizedBox(height: 24.h),
              Text(
                'Order Scanned Successfully',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Order ID: $orderId',
                style: TextStyle(
                  fontSize: 18.sp,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 32.h),
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                  context,
                  Routes.orderDetailsScreen,
                  arguments: {'orderId': orderId},
                ),
                child: const Text('View Order Details'),
              ),
              SizedBox(height: 16.h),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Scan Another Order'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
