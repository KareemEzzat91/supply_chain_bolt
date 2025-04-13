import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/core/utils/constants.dart';
import 'package:supply_chain_bolt/features/products/presentation/cubit/product_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _quantityController = TextEditingController();
  final _codeController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'Electronics';
  String? _imageUrl;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _codeController.dispose();
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
            'Add New Product',
            style: TextStyle(
              fontSize: AppTheme.headingFontSize,
              fontWeight: AppTheme.boldWeight,
            ),
          ),
        ),
        body: BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductError) {
              setState(() => _isLoading = false);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppTheme.errorColor,
                ),
              );
            } else if (state is ProductLoaded) {
              setState(() => _isLoading = false);
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
                  Text(
                    'Product Information',
                    style: TextStyle(
                      fontSize: AppTheme.subheadingFontSize,
                      fontWeight: AppTheme.boldWeight,
                    ),
                  ),
                  SizedBox(height: AppTheme.defaultPadding),
                  _buildProductImage(),
                  SizedBox(height: AppTheme.defaultPadding),
                  _buildProductForm(),
                  SizedBox(height: AppTheme.defaultPadding * 2),
                  _buildProductPreview(),
                  SizedBox(height: AppTheme.defaultPadding * 2),
                  _buildSubmitButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    return Center(
      child: Column(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: AppTheme.secondaryBackgroundColor,
              borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
              border: Border.all(color: AppTheme.borderColor),
            ),
            child: _imageUrl != null
                ? ClipRRect(
              borderRadius:
              BorderRadius.circular(AppTheme.defaultBorderRadius),
              child: Image.network(
                _imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(
                      Icons.error_outline,
                      size: 50,
                      color: AppTheme.errorColor,
                    ),
              ),
            )
                : Icon(
              Icons.add_photo_alternate,
              size: 50,
              color: AppTheme.secondaryTextColor,
            ),
          ),
          SizedBox(height: AppTheme.defaultPadding),
          Wrap(
            spacing: AppTheme.defaultPadding,
            children: [
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text('Take Photo'),
              ),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _pickImageFromGallery,
                icon: const Icon(Icons.photo_library),
                label: const Text('Choose from Gallery'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductForm() {
    return Column(
      children: [
        TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'Product Name',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.shopping_bag),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a product name';
            }
            return null;
          },
        ),
        SizedBox(height: AppTheme.defaultPadding),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.category),
          ),
          value: _selectedCategory,
          items: ['Electronics', 'Beverages', 'Food', 'Clothing']
              .map((category) =>
              DropdownMenuItem(
                value: category,
                child: Text(category),
              ))
              .toList(),
          onChanged: _isLoading
              ? null
              : (value) {
            setState(() {
              _selectedCategory = value!;
            });
          },
        ),
        SizedBox(height: AppTheme.defaultPadding),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.attach_money),
                ),
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
              child: TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(
                  labelText: 'Quantity',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory),
                ),
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
        TextFormField(
          controller: _codeController,
          decoration: const InputDecoration(
            labelText: 'Product Code',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.qr_code),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a product code';
            }
            return null;
          },
        ),
        SizedBox(height: AppTheme.defaultPadding),
        TextFormField(
          controller: _descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.description),
          ),
          maxLines: 3,
        ),
      ],
    );
  }

  Widget _buildProductPreview() {
    return Container(
      padding: EdgeInsets.all(AppTheme.defaultPadding),
      decoration: BoxDecoration(
        color: AppTheme.secondaryBackgroundColor,
        borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
        border: Border.all(color: AppTheme.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Product Preview',
            style: TextStyle(
              fontSize: AppTheme.subheadingFontSize,
              fontWeight: AppTheme.boldWeight,
              color: AppTheme.textColor,
            ),
          ),
          SizedBox(height: AppTheme.defaultPadding),
          if (_imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.defaultBorderRadius),
              child: Image.network(
                _imageUrl!,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      height: 100,
                      color: AppTheme.errorColor.withOpacity(0.1),
                      child: Icon(
                        Icons.error_outline,
                        size: 40,
                        color: AppTheme.errorColor,
                      ),
                    ),
              ),
            ),
          SizedBox(height: AppTheme.defaultPadding),
          _buildPreviewItem('Name', _nameController.text),
          _buildPreviewItem('Category', _selectedCategory),
          _buildPreviewItem('Price', '\$${_priceController.text}'),
          _buildPreviewItem('Quantity', _quantityController.text),
          _buildPreviewItem('Product Code', _codeController.text),
          if (_descriptionController.text.isNotEmpty)
            _buildPreviewItem('Description', _descriptionController.text),
        ],
      ),
    );
  }

  Widget _buildPreviewItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.defaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: AppTheme.secondaryTextColor,
                fontWeight: AppTheme.mediumWeight,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'Not set' : value,
              style: TextStyle(
                color: AppTheme.textColor,
                fontWeight: AppTheme.regularWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _submitForm,
      child: _isLoading
          ? const SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : const Text('Add Product'),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        backgroundColor: AppTheme.primaryBlue,
      ),
    );
  }

  void _pickImage() {
    // TODO: Implement camera functionality
    setState(() {
      _imageUrl = 'https://example.com/product-image.jpg';
    });
  }

  void _pickImageFromGallery() {
    // TODO: Implement gallery picker functionality
    setState(() {
      _imageUrl = 'https://example.com/product-image.jpg';
    });
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _isLoading = true);
      context.read<ProductCubit>().addProduct(
        name: _nameController.text,
        category: _selectedCategory,
        price: double.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        productCode: _codeController.text,
        description: _descriptionController.text,
        imageUrl: _imageUrl,
      );
    }
  }
}
