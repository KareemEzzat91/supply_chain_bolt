import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_helper.dart';
import '../networking/api_constants.dart';

class DioHelper implements ApiHelper {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      receiveTimeout: const Duration(seconds: 60),
      headers: {
        "Content-Type": "application/json",
        "lang": "en",
      },
    ),
  );

/*
  Future<void> _addAuthorizationHeader() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");
    if (token != null && token.isNotEmpty) {
      _dio.options.headers["Authorization"] = "Bearer $token";
    }
  }
*/

  @override
  Future<Response> getData({required String path, Map<String, dynamic>? queryParameters}) async {
/*
    await _addAuthorizationHeader();
*/
    return _dio.get(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> postData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body}) async {
/*
    await _addAuthorizationHeader();
*/
    return _dio.post(path, data: body, queryParameters: queryParameters);
  }

  @override
  Future<Response> putData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body}) async {
/*
    await _addAuthorizationHeader();
*/
    return _dio.put(path, data: body, queryParameters: queryParameters);
  }

  @override
  Future<Response> patchData({required String path, Map<String, dynamic>? queryParameters}) async {
/*
    await _addAuthorizationHeader();
*/
    return _dio.patch(path, queryParameters: queryParameters);
  }

  @override
  Future<Response> deleteData({required String path, Map<String, dynamic>? queryParameters, Map<String, dynamic>? body}) async {
/*
    await _addAuthorizationHeader();
*/
    return _dio.delete(path, data: body, queryParameters: queryParameters);
  }
}
