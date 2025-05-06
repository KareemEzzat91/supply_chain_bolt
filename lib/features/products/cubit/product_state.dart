import 'package:equatable/equatable.dart';
import 'package:supply_chain_bolt/features/products/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {
  const ProductInitial();

  @override
  String toString() => 'ProductInitial';
}

class ProductLoading extends ProductState {
  const ProductLoading();

  @override
  String toString() => 'ProductLoading';
}

class ProductLoaded extends ProductState {
  final List<Product> products;

  const ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];

  @override
  String toString() => 'ProductLoaded { products: ${products.length} }';
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => 'ProductError { message: $message }';
}
