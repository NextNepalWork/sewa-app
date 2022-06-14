import 'package:dio/dio.dart';

class DioException implements Exception {
  static String? fromDioError(DioError dioError) {
    String? message;

    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        return message;
      case DioErrorType.connectTimeout:
        message = "Connection Timeout with API server";
        return message;
      case DioErrorType.other:
        message = "No Internet Connection";
        return message;

      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        return message;
      case DioErrorType.response:
        message = handleError(
          dioError.response!.statusCode!,
        );
        return message;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        return message;
      default:
        message = "Something wrong";
    }
  }

  static String handleError(int statusCode, [String? message]) {
    switch (statusCode) {
      case 400:
        return message!.isEmpty ? "Bad Request" : message;
      case 401:
        return message!.isEmpty ? "Access Denied" : message;
      case 404:
        return message!.isEmpty
            ? "The requested information could not be found"
            : message;
      case 409:
        return message!.isEmpty ? "Conflict occurred" : message;
      case 500:
        return message!.isEmpty
            ? "Unknown error occurred, please try again later"
            : message;
      case 502:
        return "Mapping Error";

      default:
        return "Something wrong";
    }
  }
}
