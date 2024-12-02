sealed class Resource<T> {
  T? data;
  String? message;
  Resource({this.data, this.message});
}

class Success<T> extends Resource<T> {
  Success(T data) : super(data: data);
}

class Error<T> extends Resource<T> {
  Error(String message, {super.data}) : super(message: message);
}