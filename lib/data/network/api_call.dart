import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

import 'client/api_client.dart';
import 'error_handler/server_error.dart';
import 'model/album_model/album_list_model.dart';
import 'model/login_model/login.dart';
import 'response_handler/server_response.dart';

final logger = Logger();

class APICall {
  Dio dio;
  ApiClient apiClient;

  APICall() {
    dio = Dio();
    apiClient = ApiClient(dio);
  }

  //call for login user
  Future<BaseModel<LoginResponse>> loginUser(
      String userName, String password, int schoolId, bool isStudent) async {
    LoginResponse response;
    try {
      response = await apiClient.login(LoginBody(
          userName: userName,
          password: password,
          schoolId: schoolId,
          isStudent: isStudent));
    } catch (error) {
      // logger.i('Exception occured: $error stackTrace: $stacktrace');
      return BaseModel()
        ..setException(ServerError.withError(error: error as DioError));
    }
    logger.i(response.access_token);
    return BaseModel()..data = response;
  }

  //call for get album list
  Future<BaseModel<AlbumListModel>> getAlbumList(
      int pageNumber, int pageSize, String token) async {
    AlbumListModel response;
    try {
      response = await apiClient.album('Bearer $token', pageNumber, pageSize);
    } catch (error) {
      // logger.i('Exception occured: $error stackTrace: $stacktrace');
      return BaseModel()
        ..setException(ServerError.withError(error: error as DioError));
    }
    logger.i(response);
    return BaseModel()..data = response;
  }
}
