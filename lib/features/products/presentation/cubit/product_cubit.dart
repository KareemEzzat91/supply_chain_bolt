import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/features/products/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;

  const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<ProductModel> _products = [];

  void loadProducts() {
    emit(ProductLoading());
    try {
      // TODO: Implement actual API call
      _products = [
        ProductModel(
          history: [],
          id: '1',
          name: 'Sample Product',
          category: 'Electronics',
          price: 99.99,
          quantity: 10,
          productCode: 'SP001',
          description: 'Sample description',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
      ];
      emit(ProductLoaded(_products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void addProduct({
    required String name,
    required String category,
    required double price,
    required int quantity,
    required String productCode,
    String? description,
    String? imageUrl,
  }) {
    emit(ProductLoading());
    try {
      final newProduct = ProductModel(
        history: [],
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        category: category,
        price: price,
        quantity: quantity,
        productCode: productCode,
        description: description,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      _products = [..._products, newProduct];
      emit(ProductLoaded(_products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void updateProduct(ProductModel product) {
    emit(ProductLoading());
    try {
      _products =
          _products.map((p) => p.id == product.id ? product : p).toList();
      emit(ProductLoaded(_products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void deleteProduct(String productId) {
    emit(ProductLoading());
    try {
      _products = _products.where((p) => p.id != productId).toList();
      emit(ProductLoaded(_products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void filterProducts({
    String? category,
    String? searchQuery,
    String? stockStatus,
  }) {
    emit(ProductLoading());
    try {
      var filteredProducts = _products;

      if (category != null) {
        filteredProducts = filteredProducts
            .where((p) => p.category.toLowerCase() == category.toLowerCase())
            .toList();
      }

      if (searchQuery != null && searchQuery.isNotEmpty) {
        filteredProducts = filteredProducts
            .where((p) =>
                p.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
                p.productCode.toLowerCase().contains(searchQuery.toLowerCase()))
            .toList();
      }

      if (stockStatus != null) {
        filteredProducts = filteredProducts
            .where(
                (p) => p.stockStatus.toLowerCase() == stockStatus.toLowerCase())
            .toList();
      }

      emit(ProductLoaded(filteredProducts));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  String exportProducts() {
    final csv = StringBuffer();
    csv.writeln('ID,Name,Category,Price,Quantity,Stock Status,Last Updated');

    for (final product in _products) {
      csv.writeln(
        '${product.id},${product.name},${product.category},${product.price},'
        '${product.quantity},${product.stockStatus},${product.updatedAt}',
      );
    }

    return csv.toString();
  }
}
