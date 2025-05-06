import 'package:dio/dio.dart';
import 'package:supply_chain_bolt/core/networking/api_constants.dart';
import 'package:supply_chain_bolt/features/auth/data/data_source/auth_const.dart';

import '../../../../core/api_helper/api_helper.dart';

class AuthApiService {
  final ApiHelper apiHelper;
  AuthApiService(this.apiHelper);




  Future<Response> signIn(String email , String password ) async {
    return await apiHelper.postData(path:ApiConstants.auth+AuthConstants.login  ,body: {"email": email, "password": password,});
  }
  Future<Response> signUp(String name ,String email , String password,String role ) async {
    return await apiHelper.postData(path:ApiConstants.auth+AuthConstants.register ,body: {
      "name": name,
      "email": email,
      "password": password,
      "role": role
    });
  }


}
