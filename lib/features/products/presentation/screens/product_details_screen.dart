import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/products/data/models/product_model.dart';
import 'package:supply_chain_bolt/features/products/presentation/cubit/product_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  late ProductModel _product;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _descriptionController;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    _product = widget.product;
    _nameController = TextEditingController(text: _product.name);
    _priceController = TextEditingController(text: _product.price.toString());
    _quantityController =
        TextEditingController(text: _product.quantity.toString());
    _descriptionController = TextEditingController(text: _product.description);
    _selectedCategory = _product.category;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Product Details',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _showDeleteConfirmation,
            ),
          ],
        ),
        body: BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is ProductLoaded) {
              Navigator.pop(context);
            }
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.all(AppTheme.defaultPadding),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductHeader(),
                  SizedBox(height: AppTheme.defaultPadding * 2),
                  _buildProductForm(),
                  SizedBox(height: AppTheme.defaultPadding * 2),
                  _buildHistorySection(),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _submitForm,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  Widget _buildProductHeader() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.defaultPadding),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                radius: 40,
                backgroundColor: _getStockStatusColor(_product.stockStatus),
                child: Text(
                  _product.name[0],
                  style: TextStyle(
                    fontSize: AppTheme.headingFontSize,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding),
            Text(
              _product.productCode,
              style: TextStyle(
                fontSize: AppTheme.subheadingFontSize,
                color: AppTheme.secondaryTextColor,
              ),
            ),
            SizedBox(height: AppTheme.defaultPadding / 2),
            Text(
              _product.stockStatus,
              style: TextStyle(
                fontSize: AppTheme.defaultFontSize,
                color: _getStockStatusColor(_product.stockStatus),
                fontWeight: AppTheme.boldWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProductForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product Information',
          style: TextStyle(
            fontSize: AppTheme.subheadingFontSize,
            fontWeight: AppTheme.boldWeight,
          ),
        ),
        SizedBox(height: AppTheme.defaultPadding),
        _buildTextField(
          controller: _nameController,
          label: 'Product Name',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a product name';
            }
            return null;
          },
        ),
        SizedBox(height: AppTheme.defaultPadding),
        _buildCategoryDropdown(),
        SizedBox(height: AppTheme.defaultPadding),
        Row(
          children: [
            Expanded(
              child: _buildTextField(
                controller: _priceController,
                label: 'Price',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid price';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(width: AppTheme.defaultPadding),
            Expanded(
              child: _buildTextField(
                controller: _quantityController,
                label: 'Quantity',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid quantity';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        SizedBox(height: AppTheme.defaultPadding),
        _buildTextField(
          controller: _descriptionController,
          label: 'Description',
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildHistorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Product History',
          style: TextStyle(
            fontSize: AppTheme.subheadingFontSize,
            fontWeight: AppTheme.boldWeight,
          ),
        ),
        SizedBox(height: AppTheme.defaultPadding),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: _product.history.length,
          itemBuilder: (context, index) {
            final history = _product.history[index];
            return ListTile(
              leading: Icon(
                _getHistoryIcon(history.action),
                color: AppTheme.primaryBlue,
              ),
              title: Text(history.action),
              subtitle: Text(history.details),
              trailing: Text(
                _formatDate(history.timestamp),
                style: TextStyle(
                  fontSize: AppTheme.captionFontSize,
                  color: AppTheme.secondaryTextColor,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        ),
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
    );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        ),
      ),
      value: _selectedCategory,
      items: ['Electronics', 'Beverages', 'Food', 'Clothing']
          .map((category) =>
          DropdownMenuItem(
            value: category,
            child: Text(category),
          ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value!;
        });
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProduct = _product.copyWith(
        name: _nameController.text,
        category: _selectedCategory,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        description: _descriptionController.text,
      );

      context.read<ProductCubit>().updateProduct(updatedProduct);
    }
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Delete Product'),
            content: const Text(
                'Are you sure you want to delete this product?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<ProductCubit>().deleteProduct(_product.id);
                },
                child: const Text('Delete'),
              ),
            ],
          ),
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

  IconData _getHistoryIcon(String action) {
    switch (action.toLowerCase()) {
      case 'created':
        return Icons.add_circle;
      case 'updated':
        return Icons.edit;
      case 'deleted':
        return Icons.delete;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }
}
