part of core;

class BaseException extends DioException implements Exception {
  BaseException(
    RequestOptions requestOptions,
    Response<dynamic>? response,
  ) : super(requestOptions: requestOptions, response: response);

  @override
  String toString() {
    return '$runtimeType $message\n$stackTrace';
  }

  @override
  StackTrace get stackTrace {
    return StackTrace.fromString(
      'path: ${requestOptions.path}\n'
      'headers: ${requestOptions.headers},\n'
      'queryParameters: ${requestOptions.queryParameters},\n'
      'data: ${requestOptions.data},\n'
      'response: ${response?.data}',
    );
  }
}

class BadRequest extends BaseException {
  BadRequest(super.requestOptions, super.response);

  @override
  String? get message {
    try {
      return (response?.data as Map<String, dynamic>)['detail'].toString();
    } catch (_) {
      return null;
    }
  }
}

class Forbidden extends BaseException {
  Forbidden(super.requestOptions, super.response);
}

class NotFound extends BaseException {
  NotFound(super.requestOptions, super.response);
}

class Conflict extends BaseException {
  Conflict(super.requestOptions, super.response);
}

class Unauthorized extends BaseException {
  Unauthorized(super.requestOptions, super.response);
}

class ServerUnavailable extends BaseException {
  ServerUnavailable(super.requestOptions, super.response);
}

class ServerTemporarilyUnavailable extends BaseException {
  ServerTemporarilyUnavailable(super.requestOptions, super.response);
}

class NoInternetConnection extends BaseException {
  NoInternetConnection(super.requestOptions, super.response);
}

class Duplicate extends BaseException {
  Duplicate(super.requestOptions, super.response);
}

class Timeout extends BaseException {
  Timeout(super.requestOptions, super.response);
}

class TooManyRequests extends BaseException {
  TooManyRequests(super.requestOptions, super.response);
}

class UnprocessableEntity extends BaseException {
  UnprocessableEntity(super.requestOptions, super.response);
}

class NotAcceptable extends BaseException {
  NotAcceptable(super.requestOptions, super.response);
}

class UnknownError extends BaseException {
  UnknownError(super.requestOptions, super.response);
}
