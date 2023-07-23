class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() => '$_prefix$_message';
}

class InvalidUrlException extends AppException {
  InvalidUrlException(
    String? message,
  ) : super(message, 'Invalid Url');
}

class FetchDataException extends AppException {
  FetchDataException(String? message)
      : super(message, 'Error During Communication');
}

class BadRequestException extends AppException {
  BadRequestException(String? message) : super(message, 'Invalid request');
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String? message)
      : super(message, 'Unauthorized Access');
}

class NoInternetException extends AppException {
  NoInternetException(String? message) : super(message, 'No internet !');
}
