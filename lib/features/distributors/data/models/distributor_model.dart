import 'package:json_annotation/json_annotation.dart';

part 'distributor_model.g.dart';

@JsonSerializable()
class DistributorModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String area;
  final String? email;
  final String status;
  final double rating;
  final int completedOrders;
  final DateTime joinDate;
  final List<String> assignedOrders;
  final double averageDeliveryTime;
  final Map<String, dynamic>? lastLocation;
  final Map<String, dynamic>? performanceMetrics;

  DistributorModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.area,
    this.email,
    this.status = 'Active',
    this.rating = 0.0,
    this.completedOrders = 0,
    required this.joinDate,
    this.assignedOrders = const [],
    this.averageDeliveryTime = 0.0,
    this.lastLocation,
    this.performanceMetrics,
  });

  factory DistributorModel.fromJson(Map<String, dynamic> json) =>
      _$DistributorModelFromJson(json);

  Map<String, dynamic> toJson() => _$DistributorModelToJson(this);

  DistributorModel copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? area,
    String? email,
    String? status,
    double? rating,
    int? completedOrders,
    DateTime? joinDate,
    List<String>? assignedOrders,
    double? averageDeliveryTime,
    Map<String, dynamic>? lastLocation,
    Map<String, dynamic>? performanceMetrics,
  }) {
    return DistributorModel(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      area: area ?? this.area,
      email: email ?? this.email,
      status: status ?? this.status,
      rating: rating ?? this.rating,
      completedOrders: completedOrders ?? this.completedOrders,
      joinDate: joinDate ?? this.joinDate,
      assignedOrders: assignedOrders ?? this.assignedOrders,
      averageDeliveryTime: averageDeliveryTime ?? this.averageDeliveryTime,
      lastLocation: lastLocation ?? this.lastLocation,
      performanceMetrics: performanceMetrics ?? this.performanceMetrics,
    );
  }
}
