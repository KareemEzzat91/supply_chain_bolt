import 'package:dio/dio.dart';

abstract class ApiHelper {
  Future<Response> getData({required String path, Map<String, dynamic>? queryParameters});
  Future<Response> postData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body});
  Future<Response> putData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body});
  Future<Response> patchData({required String path, Map<String, dynamic>? queryParameters});
  Future<Response> deleteData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body});
}