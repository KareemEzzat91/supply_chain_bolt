class LoginResponseModel {
  bool? success;
  Data? data;

  LoginResponseModel({this.success, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

}

class Data {
  String? message;
  String? email;
  String? name;
  String? role;

  Data({this.message, this.email, this.name, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
  }


}
