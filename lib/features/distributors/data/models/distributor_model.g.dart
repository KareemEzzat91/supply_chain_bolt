// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distributor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributorModel _$DistributorModelFromJson(Map<String, dynamic> json) =>
    DistributorModel(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      phoneNumber: json['phoneNumber'] as String,
      area: json['area'] as String,
      email: json['email'] as String?,
      status: json['status'] as String? ?? 'Active',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      completedOrders: (json['completedOrders'] as num?)?.toInt() ?? 0,
      joinDate: DateTime.parse(json['joinDate'] as String),
      assignedOrders: (json['assignedOrders'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      averageDeliveryTime:
          (json['averageDeliveryTime'] as num?)?.toDouble() ?? 0.0,
      lastLocation: json['lastLocation'] as Map<String, dynamic>?,
      performanceMetrics: json['performanceMetrics'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DistributorModelToJson(DistributorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fullName': instance.fullName,
      'phoneNumber': instance.phoneNumber,
      'area': instance.area,
      'email': instance.email,
      'status': instance.status,
      'rating': instance.rating,
      'completedOrders': instance.completedOrders,
      'joinDate': instance.joinDate.toIso8601String(),
      'assignedOrders': instance.assignedOrders,
      'averageDeliveryTime': instance.averageDeliveryTime,
      'lastLocation': instance.lastLocation,
      'performanceMetrics': instance.performanceMetrics,
    };
