import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final int quantity;
  final String productCode;
  final String? imageUrl;
  final String? description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ProductHistory> history;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    required this.productCode,
    this.imageUrl,
    this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.history,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductModel copyWith({
    String? name,
    String? category,
    double? price,
    int? quantity,
    String? productCode,
    String? imageUrl,
    String? description,
  }) {
    return ProductModel(
      id: id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      productCode: productCode ?? this.productCode,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      history: [
        ...history,
        ProductHistory(
          action: 'Updated',
          timestamp: DateTime.now(),
          details: 'Product details updated',
        ),
      ],
    );
  }

  String get stockStatus {
    if (quantity <= 0) return 'Out of Stock';
    if (quantity <= 10) return 'Low Stock';
    return 'In Stock';
  }
}

@JsonSerializable()
class ProductHistory {
  final String action;
  final DateTime timestamp;
  final String details;

  ProductHistory({
    required this.action,
    required this.timestamp,
    required this.details,
  });

  factory ProductHistory.fromJson(Map<String, dynamic> json) =>
      _$ProductHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$ProductHistoryToJson(this);
}
