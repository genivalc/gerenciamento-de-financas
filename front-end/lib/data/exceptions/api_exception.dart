class APIException implements Exception {
  final int statusCode;
  final String statusText;
  final String message;

  APIException(this.statusCode, this.statusText, this.message);
}