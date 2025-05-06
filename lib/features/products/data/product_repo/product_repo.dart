import 'package:supply_chain_bolt/core/networking/api_result.dart';
import 'package:supply_chain_bolt/features/products/data/models/product_model.dart';
import 'package:supply_chain_bolt/features/products/data/product_api_servicer/product_api_servicer.dart';

class ProductRepository {
  final ProductApiServicer productApiServicer;

  ProductRepository({required this.productApiServicer});

  Future<List<Product>> getProducts() async {
    try {
      final productJson = await productApiServicer.getProducts();

      List<Product> products = productJson.map((product) {
        return Product.fromJson(product);
      }).toList();

      return products;
    } catch (e) {
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final productJson = await productApiServicer.getProductById(id);
      return Product.fromJson(productJson);
    } catch (e) {
      throw Exception('Failed to fetch product: $e');
    }
  }

  Future<ApiResult> deleteProductById(int id) async {
    try {
      await productApiServicer.deleteProductById(id);
      return ApiResult.success('Product deleted successfully');
    } catch (e) {
      return ApiResult.error('Failed to delete product: $e');
    }
  }

  Future<Product> addProduct(Product product) async {
    try {
      final newProductJson =
          await productApiServicer.addProduct(product.toJson());
      return Product.fromJson(newProductJson);
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  Future<Product> updateProduct(Product product) async {
    try {
      final updatedProductJson =
          await productApiServicer.updateProduct(product.toJson());
      return Product.fromJson(updatedProductJson);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }
}
