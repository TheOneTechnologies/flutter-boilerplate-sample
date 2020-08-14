import 'dart:convert';

import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int _errorCode;
  String _errorMessage = '';

  ServerError.withError({DioError error}) {
    _handleError(error);
  }

  int getErrorCode() {
    return _errorCode;
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  String _handleError(DioError error) {
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = 'Request was cancelled';
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = 'Connection timeout';
        break;
      case DioErrorType.DEFAULT:
        _errorMessage = 'Connection failed due to internet connection';
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = 'Receive timeout in connection';
        break;
      case DioErrorType.RESPONSE:
        {
          //changes according to your api error response
          if(error.response.statusCode == 401){
            _errorMessage = error.response.statusMessage;
          }else{
            var data = json.decode(error.response.toString());
            var errorList = data['errors'] as List;
            _errorMessage = errorList[0]['message'] as String;
          }
        }
        break;
      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = 'Receive timeout in send request';
        break;
    }
    return _errorMessage;
  }
}
