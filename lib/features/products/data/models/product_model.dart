import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

/// Product model with full null safety and robust (de)serialization.
@JsonSerializable()
class Product extends Equatable {
  final int? id;
  final String name;
  final String barcode;
  final double price;
  final int stockQuantity;
  final String category;
  final String? description;

  /// All fields except 'id' and 'description' are required and non-nullable.
  const Product({
    this.id,
    required this.name,
    required this.barcode,
    required this.price,
    required this.stockQuantity,
    required this.category,
    this.description,
  });

  /// Creates a Product from a JSON map, handling nulls gracefully
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: (json['id'] as num?)?.toInt(),
        name: (json['name'] as String?) ?? '',
        barcode: (json['barcode'] as String?) ?? '',
        price: (json['price'] as num?)?.toDouble() ?? 0.0,
        stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
        category: (json['category'] as String?) ?? '',
        description: json['description'] as String?,
      );

  /// Converts the Product to a JSON map, omitting nulls and using defaults
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'barcode': barcode,
        'price': price,
        'stockQuantity': stockQuantity,
        'category': category,
        if (description != null) 'description': description,
      };

  /// Creates a copy of the Product with the given fields replaced with new values
  Product copyWith({
    int? id,
    String? name,
    String? barcode,
    double? price,
    int? stockQuantity,
    String? category,
    String? description,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      barcode: barcode ?? this.barcode,
      price: price ?? this.price,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      category: category ?? this.category,
      description: description ?? this.description,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        barcode,
        price,
        stockQuantity,
        category,
        description,
      ];
}
