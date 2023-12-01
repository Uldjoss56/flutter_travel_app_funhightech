class AuthException implements Exception {
  final String message;

  AuthException(this.message);
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException() : super('Invalid credentials');
}

class NetworkException extends AuthException {
  NetworkException() : super('Connexion à internet');
}

class ServerException extends AuthException {
  ServerException() : super('Server error');
}
