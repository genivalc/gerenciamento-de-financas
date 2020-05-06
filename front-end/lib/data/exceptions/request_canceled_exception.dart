class RequestCanceledException implements Exception  {
  final String message;

  RequestCanceledException(this.message);
}