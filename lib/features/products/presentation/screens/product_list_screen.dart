import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/di/dependency_injection.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/distributors/presentation/screens/distributor_management_screen.dart';
import 'package:supply_chain_bolt/features/products/cubit/product_cubit.dart';
import 'package:supply_chain_bolt/features/products/cubit/product_state.dart';
import 'package:supply_chain_bolt/features/products/data/models/product_model.dart';
import 'package:supply_chain_bolt/features/products/data/product_repo/product_repo.dart';
import 'package:supply_chain_bolt/features/products/presentation/screens/add_product_screen.dart';
import 'package:supply_chain_bolt/features/products/presentation/screens/product_details_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  static const List<String> allowedCategories = [
    'All Categories',
    'Electronics',
    'Beverages',
    'Food',
    'Clothing'
  ];
  String? _selectedCategory;
  String _searchQuery = '';
  final _refreshKey = GlobalKey<RefreshIndicatorState>();

  late ProductCubit _productCubit;

  @override
  void initState() {
    super.initState();
    _productCubit =
        ProductCubit(productRepository: locator.get<ProductRepository>());
    _productCubit.getProducts();
    _selectedCategory = 'All Categories';
  }

  Future<void> _refreshProducts() async {
    _productCubit.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productCubit,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          title: const Text(
            'Product Management',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
              color: Colors.white,
            ),
          ),
          actions: [
            TextButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const DistributorManagementScreen()),
              ),
              icon: const Icon(Icons.people, color: Colors.white),
              label: const Text(
                'DistMangment',
                style: TextStyle(color: Colors.white),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.white),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: _productCubit,
                    child: const AddProductScreen(),
                  ),
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
                  if (state is ProductLoading) {
                    return _buildLoadingSkeleton();
                  }
                  if (state is ProductError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline,
                              size: 48, color: AppTheme.errorColor),
                          const SizedBox(height: 16),
                          Text(
                            state.message,
                            style: const TextStyle(color: AppTheme.errorColor),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _refreshProducts,
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is ProductLoaded) {
                    final filtered = state.products.where((product) {
                      final matchesCategory =
                          _selectedCategory == 'All Categories' ||
                              product.category == _selectedCategory;
                      final matchesSearch = product.name
                          .toLowerCase()
                          .contains(_searchQuery.toLowerCase());
                      return matchesCategory && matchesSearch;
                    }).toList();

                    if (filtered.isEmpty) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.search_off,
                                size: 48, color: AppTheme.secondaryTextColor),
                            const SizedBox(height: 16),
                            Text(
                              _searchQuery.isNotEmpty
                                  ? 'No products found matching "$_searchQuery"'
                                  : 'No products available',
                              style: const TextStyle(
                                  color: AppTheme.secondaryTextColor),
                            ),
                          ],
                        ),
                      );
                    }

                    return RefreshIndicator(
                      key: _refreshKey,
                      onRefresh: _refreshProducts,
                      child: _buildProductList(filtered),
                    );
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
    return Container(
      padding: const EdgeInsets.all(AppTheme.defaultPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search products...',
              prefixIcon:
                  Icon(Icons.search, color: Theme.of(context).iconTheme.color),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppTheme.defaultBorderRadius),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppTheme.defaultBorderRadius),
                borderSide: BorderSide(color: Theme.of(context).dividerColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(AppTheme.defaultBorderRadius),
                borderSide: BorderSide(color: Theme.of(context).primaryColor),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
            ),
            style: Theme.of(context).textTheme.bodyMedium,
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          const SizedBox(height: AppTheme.defaultPadding),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Category',
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.defaultBorderRadius),
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.defaultBorderRadius),
                      borderSide:
                          BorderSide(color: Theme.of(context).dividerColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(AppTheme.defaultBorderRadius),
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                  value: allowedCategories.contains(_selectedCategory)
                      ? _selectedCategory
                      : null,
                  items: allowedCategories
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(category,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<Product> products) {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.defaultPadding),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.only(bottom: AppTheme.defaultPadding),
          elevation: 2,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
          ),
          child: InkWell(
            onTap: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: _productCubit,
                    child: ProductDetailsScreen(product: product),
                  ),
                ),
              );
              if (updated == true) {
                _productCubit.getProducts();
              }
            },
            borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
            child: Padding(
              padding: const EdgeInsets.all(AppTheme.defaultPadding),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _getStockStatusColor(product.stockQuantity)
                          .withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(AppTheme.defaultBorderRadius),
                    ),
                    child: Center(
                      child: Text(
                        product.name.isNotEmpty
                            ? product.name[0].toUpperCase()
                            : '?',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: AppTheme.boldWeight,
                              color:
                                  _getStockStatusColor(product.stockQuantity),
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppTheme.defaultPadding),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(fontWeight: AppTheme.boldWeight),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          product.category,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              Icons.inventory_2_outlined,
                              size: 16,
                              color:
                                  _getStockStatusColor(product.stockQuantity),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${product.stockQuantity} in stock',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: _getStockStatusColor(
                                          product.stockQuantity)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        product.price.toStringAsFixed(2),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontWeight: AppTheme.boldWeight,
                            color: AppTheme.primaryBlue),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: _getStockStatusColor(product.stockQuantity)
                              .withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getStockStatusText(product.stockQuantity),
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: _getStockStatusColor(
                                      product.stockQuantity)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.defaultPadding),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: AppTheme.defaultPadding),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.defaultPadding),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius:
                        BorderRadius.circular(AppTheme.defaultBorderRadius),
                  ),
                ),
                const SizedBox(width: AppTheme.defaultPadding),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 120,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 80,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: 100,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: 60,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: 80,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getStockStatusColor(int stockQuantity) {
    if (stockQuantity == 0) return AppTheme.errorColor;
    if (stockQuantity <= 5) return AppTheme.warningColor;
    return AppTheme.successColor;
  }

  String _getStockStatusText(int stockQuantity) {
    if (stockQuantity == 0) return 'Out of Stock';
    if (stockQuantity <= 5) return 'Low Stock';
    return 'In Stock';
  }
}
