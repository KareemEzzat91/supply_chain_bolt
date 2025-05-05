import 'package:supply_chain_bolt/core/api_helper/api_helper.dart';
import 'package:supply_chain_bolt/core/networking/api_result.dart';
import 'package:supply_chain_bolt/features/auth/data/models/response_model.dart';

import '../data_source/auth_api_service.dart';

class AuthRepo {
  final AuthApiService apiService;

  AuthRepo(this.apiService);


  Future<ApiResult<LoginResponseModel>> loginAsManager(String email, String password) async {
    try {
      final response = await apiService.signIn(email,password );
        if (response.statusCode==200) {
         return  ApiResult.success(LoginResponseModel.fromJson(response.data));
        } else {
          return ApiResult.error(response.data);
        }

    } catch (e) {
      return ApiResult.error(e);
    }
  }
  Future<ApiResult<LoginResponseModel>> loginAsDistributor(String email, String password) async {
    try {
      final response = await apiService.signIn(email,password );
      if (response.statusCode==200) {
        return  ApiResult.success(LoginResponseModel.fromJson(response.data));
      } else {
        return ApiResult.error(response.data);
      }

    } catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<RegisterResponseModel>> registerAsDistributor(String email, String password,String role ) async {
    try {
      final response = await apiService.signUp(email,password,role  );
      if (response.statusCode==200) {
        return  ApiResult.success(RegisterResponseModel.fromJson(response.data));
      } else {
        return ApiResult.error(response.data);
      }

    } catch (e) {
      return ApiResult.error(e);
    }
  }
  Future<ApiResult<RegisterResponseModel>> registerAsManger(String email, String password,String role) async {
    try {
    final response = await apiService.signUp(email,password,role  );
    if (response.statusCode==200) {
      return  ApiResult.success(RegisterResponseModel.fromJson(response.data));
    } else {
      return ApiResult.error(response.data);
    }

  } catch (e) {
    return ApiResult.error(e);
  }
  }

}
