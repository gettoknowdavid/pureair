import 'package:pureair/src/core/server_error.dart';

class BaseModel<T> {
  ServerError _error;
  T data;

  setException(ServerError error) => _error = error;

  setData(T data) => this.data = data;

  ServerError get getException {
    return _error;
  }
}
