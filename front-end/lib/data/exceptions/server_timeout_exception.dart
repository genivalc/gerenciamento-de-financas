class ServerTimeoutException implements Exception  {
  final String message;

  ServerTimeoutException(this.message);
}