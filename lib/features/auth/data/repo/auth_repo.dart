import 'package:supply_chain_bolt/core/networking/api_result.dart';
import 'package:supply_chain_bolt/features/auth/data/models/response_model.dart';

import '../data_source/auth_api_service.dart';

class AuthRepo {
  final AuthApiService apiService;

  AuthRepo(this.apiService);


  Future<ApiResult<LoginResponseModel>> loginAsManager(String email, String password) async {
    try {
      final response = await apiService.signIn(email,password );
        if (response.statusCode==200 ||response.statusCode==201) {
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
      if (response.statusCode==200||response.statusCode==201) {
        return  ApiResult.success(LoginResponseModel.fromJson(response.data));
      } else {
        return ApiResult.error(response.data);
      }

    } catch (e) {
      return ApiResult.error(e);
    }
  }

  Future<ApiResult<LoginResponseModel>> registerAsDistributor(String name ,String email, String password,String role ) async {
    try {
      final response = await apiService.signUp(name,email,password,role);
      if (response.statusCode==200||response.statusCode==201) {

        return  ApiResult.success(LoginResponseModel.fromJson(response.data));

      } else {

        return ApiResult.error(response.data);
      }

    } catch (e) {


      return ApiResult.error(e);
    }
  }
  Future<ApiResult<LoginResponseModel>> registerAsManger(String name ,String email, String password,String role) async {
    try {
    final response = await apiService.signUp(name ,email,password,role);
    if (response.statusCode==200||response.statusCode==201) {
      return  ApiResult.success(LoginResponseModel.fromJson(response.data));
    } else {
      return ApiResult.error(response.data);
    }

  } catch (e) {

      return ApiResult.error(e);
  }
  }

}
