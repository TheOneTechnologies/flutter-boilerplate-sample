import 'package:json_annotation/json_annotation.dart';
part 'login.g.dart';

@JsonSerializable()
class LoginBody{
  String userName;
  String password;
  int schoolId;
  bool isStudent;

  LoginBody({this.userName, this.password, this.schoolId, this.isStudent});

  factory LoginBody.fromJson(Map<String, dynamic> json) => _$LoginBodyFromJson(json);
  Map<String, dynamic> toJson() => _$LoginBodyToJson(this);
}


@JsonSerializable()
class LoginResponse {
  String access_token;
  String token_type;
  int expires_in;
  String refresh_token;

  LoginResponse({this.access_token, this.token_type, this.expires_in, this.refresh_token});

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

