import 'package:core/core.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppInterceptor extends QueuedInterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (await InternetConnectionChecker().hasConnection) {
      super.onRequest(options, handler);
    } else {
      handler.reject(NoInternetConnection(options, null));
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response != null) {
      AppLogger.logResponse(err.response!);
    }

    switch (err.response?.statusCode) {
      case 400:
        super.onError(BadRequest(err.requestOptions, err.response), handler);
      case 401:
        super.onError(Unauthorized(err.requestOptions, err.response), handler);
      case 403:
        super.onError(Forbidden(err.requestOptions, err.response), handler);
      case 404:
        super.onError(NotFound(err.requestOptions, err.response), handler);
      case 406:
        super.onError(NotAcceptable(err.requestOptions, err.response), handler);
      case 409:
        super.onError(Conflict(err.requestOptions, err.response), handler);
      case 429:
        super.onError(TooManyRequests(err.requestOptions, err.response), handler);
      case 422:
        super.onError(UnprocessableEntity(err.requestOptions, err.response), handler);
      case 500:
        super.onError(ServerUnavailable(err.requestOptions, err.response), handler);
      case 502:
        super.onError(ServerUnavailable(err.requestOptions, err.response), handler);
      case 503:
        super.onError(ServerTemporarilyUnavailable(err.requestOptions, err.response), handler);
      default:
        super.onError(UnknownError(err.requestOptions, err.response), handler);
        break;
    }
  }
}
