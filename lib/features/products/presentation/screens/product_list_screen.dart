import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/products/data/models/product_model.dart';
import 'package:supply_chain_bolt/features/products/presentation/cubit/product_cubit.dart';
import 'package:supply_chain_bolt/features/products/presentation/screens/add_product_screen.dart';
import 'package:supply_chain_bolt/features/products/presentation/screens/product_details_screen.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_management_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  String? _selectedCategory;
  String? _selectedStockStatus;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => ProductCubit(),
  child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product Management',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DistributorManagementScreen(),
                ),
              ),
              icon: const Icon(Icons.people),
              label: const Text('DistMangment'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddProductScreen(),
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            _buildFilters(),
            Expanded(
              child: BlocBuilder<ProductCubit, ProductState>(
                builder: (context, state) {
                  context.read<ProductCubit>().loadProducts();
                  if (state is ProductLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is ProductError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is ProductLoaded) {
                        context.read<ProductCubit>().filterProducts(
                              category: _selectedCategory,
                              searchQuery: _searchQuery,
                              stockStatus: _selectedStockStatus,
                            );
                    return _buildProductList(state.products);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
);
  }

  Widget _buildFilters() {
    return Card(
      margin: const EdgeInsets.all(AppTheme.defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppTheme.defaultBorderRadius),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
            SizedBox(height: AppTheme.defaultPadding),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.defaultBorderRadius),
                      ),
                    ),
                    value: _selectedCategory,
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Categories'),
                      ),
                      ...['Electronics', 'Beverages', 'Food', 'Clothing']
                          .map((category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ))
                          .toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                ),
                SizedBox(width: AppTheme.defaultPadding),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Stock Status',
                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.defaultBorderRadius),
                      ),
                    ),
                    value: _selectedStockStatus,
                    items: [
                      const DropdownMenuItem(
                        value: null,
                        child: Text('All Status'),
                      ),
                      ...['In Stock', 'Low Stock', 'Out of Stock']
                          .map((status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ))
                          .toList(),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedStockStatus = value;
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList(List<ProductModel> products) {
    return ListView.builder(
      padding: EdgeInsets.all(AppTheme.defaultPadding),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: EdgeInsets.only(bottom: AppTheme.defaultPadding),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _getStockStatusColor(product.stockStatus),
              child: Text(
                product.name[0],
                style: const TextStyle(color: Colors.white),
              ),
            ),
            title: Text(
              product.name,
              style: const TextStyle(
                fontSize: AppTheme.defaultFontSize,
                fontWeight: AppTheme.boldWeight,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Code: ${product.productCode}',
                  style: const TextStyle(
                    fontSize: AppTheme.captionFontSize,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
                Text(
                  'Stock: ${product.quantity} | ${product.stockStatus}',
                  style: const TextStyle(
                    fontSize: AppTheme.captionFontSize,
                    color: AppTheme.secondaryTextColor,
                  ),
                ),
              ],
            ),
            trailing: Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: AppTheme.defaultFontSize,
                fontWeight: AppTheme.boldWeight,
                color: AppTheme.primaryBlue,
              ),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(product: product),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStockStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in stock':
        return AppTheme.successColor;
      case 'low stock':
        return AppTheme.warningColor;
      case 'out of stock':
        return AppTheme.errorColor;
      default:
        return AppTheme.secondaryTextColor;
    }
  }
}
