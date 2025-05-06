import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/di/dependency_injection.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/products/cubit/product_cubit.dart';
import 'package:supply_chain_bolt/features/products/data/product_repo/product_repo.dart';

class NewOrderScreen extends StatelessWidget {
  const NewOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(
        productRepository:locator.get<ProductRepository>(),
      ) ,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'New Order',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Details',
                style: TextStyle(
                  fontSize: AppTheme.subheadingFontSize,
                  fontWeight: AppTheme.boldWeight,
                ),
              ),
              SizedBox(height: AppTheme.defaultPadding),
              _buildOrderForm(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderForm() {
    return Form(
      child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Customer Name',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: AppTheme.defaultPadding),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Delivery Address',
              border: OutlineInputBorder(),
            ),
            maxLines: 2,
          ),
          SizedBox(height: AppTheme.defaultPadding),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Phone Number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: AppTheme.defaultPadding),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Payment Method',
              border: OutlineInputBorder(),
            ),
            items: ['Cash', 'Credit Card', 'Bank Transfer']
                .map((method) =>
                DropdownMenuItem(
                  value: method,
                  child: Text(method),
                ))
                .toList(),
            onChanged: (value) {},
          ),
          SizedBox(height: AppTheme.defaultPadding * 2),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Create Order'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ],
      ),
    );
  }
}
