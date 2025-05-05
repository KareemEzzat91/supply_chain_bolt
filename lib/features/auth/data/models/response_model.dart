class LoginResponseModel{
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? expiresIn;
  String? scope;
  String? jti;

  LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.scope,
    this.jti,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    data['jti'] = jti;
    return data;
  }

}
class RegisterResponseModel {
  String? accessToken;
  String? refreshToken;
  String? tokenType;
  String? expiresIn;
  String? scope;
  String? jti;

  RegisterResponseModel({
    this.accessToken,
    this.refreshToken,
    this.tokenType,
    this.expiresIn,
    this.scope,
    this.jti,
  });

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    refreshToken = json['refresh_token'];
    tokenType = json['token_type'];
    expiresIn = json['expires_in'];
    scope = json['scope'];
    jti = json['jti'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['refresh_token'] = refreshToken;
    data['token_type'] = tokenType;
    data['expires_in'] = expiresIn;
    data['scope'] = scope;
    data['jti'] = jti;
    return data;
  }
}