/*
here we will create some custom exception and during API consuming we will use this
*/
class AppException implements Exception {
  final dynamic _message;

  AppException([this._message]);

  @override
  String toString() {
    return '$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message]) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([message]) : super(message);
}

class ValidationException extends AppException {
  ValidationException([message]) : super(message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message]) : super(message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message);
}

class AlreadySyncedException extends AppException {
  AlreadySyncedException([String? message]) : super(message);
}

class DataParseException extends AppException {
  DataParseException([String? message]) : super(message);
}

class InternalServerException extends AppException {
  InternalServerException([String? message]) : super(message);
}
