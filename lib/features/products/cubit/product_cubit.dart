import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supply_chain_bolt/features/products/cubit/product_state.dart';
import 'package:supply_chain_bolt/features/products/data/models/product_model.dart';
import 'package:supply_chain_bolt/features/products/data/product_repo/product_repo.dart';

class ProductCubit extends Cubit<ProductState> {
  final ProductRepository productRepository;

  ProductCubit({required this.productRepository})
      : super(const ProductInitial());

  List<Product> _products = [];

  void getProducts() async {
    emit(const ProductLoading());
    try {
      _products = await productRepository.getProducts();
      emit(ProductLoaded(List<Product>.from(_products)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> addProduct(Product product) async {
    emit(const ProductLoading());
    try {
      final newProduct = await productRepository.addProduct(product);
      _products.add(newProduct);
      emit(ProductLoaded(List<Product>.from(_products)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> updateProduct(Product product) async {
    emit(const ProductLoading());
    try {
      if (product.id == null) {
        emit(const ProductError('Product ID is required for update'));
        return;
      }

      final updatedProduct = await productRepository.updateProduct(product);
      _products.removeWhere((p) => p.id == product.id);
      _products.add(updatedProduct);
      emit(ProductLoaded(List<Product>.from(_products)));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> deleteProduct(int id) async {
    emit(const ProductLoading());
    try {
      final result = await productRepository.deleteProductById(id);
      result.when(
        onSuccess: (_) {
          _products.removeWhere((product) => product.id == id);
          emit(ProductLoaded(List<Product>.from(_products)));
        },
        onError: (error) {
          emit(ProductError(error.message));
        },
      );
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  void filterProducts(String query) {
    emit(const ProductLoading());
    try {
      final filtered = _products
          .where((product) =>
              product.name.toLowerCase().contains(query.toLowerCase()) ||
              product.category.toLowerCase().contains(query.toLowerCase()))
          .toList();
      emit(ProductLoaded(filtered));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
