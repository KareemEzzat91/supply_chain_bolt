/*
import 'package:supply_chain_bolt/core/api_helper/api_helper.dart';
import 'package:supply_chain_bolt/core/networking/api_result.dart';
import 'package:supply_chain_bolt/features/auth/data_source/auth_api_service.dart';

class AuthRepo {
  final AuthApiService apiService;

  AuthRepo(this.apiService);

  Future<void> loginAsManager(String email, String password) async {
    try {
      final response = await apiService.postData(
        path: '/manager/login',
        body: {'email': email, 'password': password},
      );
      // Handle response (e.g., parse token, user data, etc.)
    } catch (e) {
      rethrow; // Propagate the error to be handled by the caller
    }
  }

  Future<void> loginAsDistributor(String email, String password) async {
    try {
      final response = await apiService.postData(
        path: '/distributor/login',
        body: {'email': email, 'password': password},
      );
      // Handle response (e.g., parse token, user data, etc.)
    } catch (e) {
      rethrow; // Propagate the error to be handled by the caller
    }
  }

  Future<void> registerAsDistributor(String email, String password) async {
    try {
      final response = await apiService.postData(
        path: '/distributor/login',
        body: {'email': email, 'password': password},
      );
      // Handle response (e.g., parse token, user data, etc.)
    } catch (e) {
      rethrow; // Propagate the error to be handled by the caller
    }
  }
  Future<void> registerAsManger(String email, String password) async {
    try {
      final = await apiService.postData(
        path: '/distributor/login',
        body: {'email': email, 'password': password},
      );
      // Handle response (e.g., parse token, user data, etc.)
    } catch (e) {
      rethrow; // Propagate the error to be handled by the caller
    }
  }

}*/
