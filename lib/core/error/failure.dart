import 'package:dio/dio.dart';

/// Maps an exception to a short, user-facing message. The backend returns
/// {success, message, errors} on failure, so we surface `message`; otherwise we
/// translate the Dio error type / status code into something readable.
String friendlyError(Object e) {
  if (e is DioException) {
    final data = e.response?.data;
    if (data is Map && data['message'] is String && (data['message'] as String).trim().isNotEmpty) {
      return (data['message'] as String).trim();
    }
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'The connection timed out. Please try again.';
      case DioExceptionType.connectionError:
        return "Can't reach the server. Check your connection.";
      default:
        switch (e.response?.statusCode) {
          case 401:
            return 'Your session expired. Please sign in again.';
          case 402:
            return 'A subscription or purchase is required to watch this.';
          case 403:
            return "You don't have access to this.";
          case 404:
            return 'Not found.';
          case 409:
            return 'Stream limit reached. Stop playback on another device.';
          case 429:
            return 'Too many attempts. Please wait a moment.';
          default:
            return 'Something went wrong. Please try again.';
        }
    }
  }
  return e.toString();
}
