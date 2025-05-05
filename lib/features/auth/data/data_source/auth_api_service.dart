import 'package:dio/dio.dart';
import 'package:supply_chain_bolt/core/networking/api_constants.dart';

import '../../../../core/api_helper/api_helper.dart';

class AuthApiService {
  final ApiHelper apiHelper;
  AuthApiService(this.apiHelper);

  Future<Response> signIn(String email , String password ) async {
    return await apiHelper.postData(path:ApiConstants.signIn  ,body: {"email": email, "password": password,});
  }
  Future<Response> signUp(String email , String password,String role ) async {
    return await apiHelper.postData(path:ApiConstants.signUp ,body: {
      "email": email,
      "password": password,
      "role": role
    });
  }
}
