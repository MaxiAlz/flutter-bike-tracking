class WrongCredentials implements Exception {}

class InvalidToken implements Exception {}

class ConnectionTimeout implements Exception {
  final String? message;

  ConnectionTimeout({this.message});
}

class CustomError implements Exception {
  final String message;

  CustomError({
    required this.message,
  });
}
