import 'package:supply_chain_bolt/core/api_helper/api_helper.dart';
import 'package:supply_chain_bolt/core/networking/api_constants.dart';

class ProductApiServicer {
  final ApiHelper apiHelper;
  ProductApiServicer({required this.apiHelper});

  Future<List<dynamic>> getProducts() async {
    final response = await apiHelper.getData(path: ApiConstants.products);

    if (response.statusCode == null) {
      throw Exception('No response received from server');
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data is List) {
        return response.data as List<dynamic>;
      } else {
        throw Exception('Invalid response format: expected a list of products');
      }
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }

  Future<dynamic> getProductById(int id) async {
    final response = await apiHelper.getData(
      path: ApiConstants.products,
      queryParameters: {'id': id},
    );

    if (response.statusCode == null) {
      throw Exception('No response received from server');
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data != null) {
        return response.data;
      } else {
        throw Exception('Product not found');
      }
    } else {
      throw Exception('Failed to load product: ${response.statusCode}');
    }
  }

  Future<dynamic> deleteProductById(int id) async {
    final response = await apiHelper.deleteData(
      path: '${ApiConstants.products}/$id',
    );

    if (response.statusCode == null) {
      throw Exception('No response received from server');
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return response.data;
    } else {
      throw Exception('Failed to delete product: ${response.statusCode}');
    }
  }

  Future<dynamic> addProduct(Map<String, dynamic> product) async {
    final response = await apiHelper.postData(
      path: ApiConstants.products,
      body: product,
    );

    if (response.statusCode == null) {
      throw Exception('No response received from server');
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data != null) {
        return response.data;
      } else {
        throw Exception('Failed to create product: no data returned');
      }
    } else {
      throw Exception('Failed to add product: ${response.statusCode}');
    }
  }

  Future<dynamic> updateProduct(Map<String, dynamic> product) async {
    if (product['id'] == null) {
      throw Exception('Product ID is required for update');
    }
    final response = await apiHelper.putData(
      path: '${ApiConstants.products}/${product['id']}',
      body: product,
    );

    if (response.statusCode == null) {
      throw Exception('No response received from server');
    }

    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      if (response.data != null) {
        return response.data;
      } else {
        throw Exception('Failed to update product: no data returned');
      }
    } else {
      throw Exception('Failed to update product: ${response.statusCode}');
    }
  }
}
