import '../error_handler/server_error.dart';

class BaseModel<T> {
  ServerError _error;
  T data;

  void setException(ServerError error) {
    _error = error;
  }

  void setData(T data) {
    this.data = data;
  }

  ServerError get getException {
    return _error;
  }
}