// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBody _$LoginBodyFromJson(Map<String, dynamic> json) {
  return LoginBody(
    userName: json['userName'] as String,
    password: json['password'] as String,
    schoolId: json['schoolId'] as int,
    isStudent: json['isStudent'] as bool,
  );
}

Map<String, dynamic> _$LoginBodyToJson(LoginBody instance) => <String, dynamic>{
      'userName': instance.userName,
      'password': instance.password,
      'schoolId': instance.schoolId,
      'isStudent': instance.isStudent,
    };

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) {
  return LoginResponse(
    access_token: json['access_token'] as String,
    token_type: json['token_type'] as String,
    expires_in: json['expires_in'] as int,
    refresh_token: json['refresh_token'] as String,
  );
}

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'access_token': instance.access_token,
      'token_type': instance.token_type,
      'expires_in': instance.expires_in,
      'refresh_token': instance.refresh_token,
    };
