part of core;

class AppLogger {
  static final _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 9,
      errorMethodCount: 9,
      lineLength: 100,
      printTime: true,
    ),
  );

  static void logResponse(Response<dynamic> response) {
    final data = _formatJson(response.data);
    final message = '--- request ---\n'
        'url: ${response.requestOptions.baseUrl}\n'
        'path: ${response.requestOptions.path}\n'
        'data: ${_formatJson(response.requestOptions.data)}\n'
        'method: ${response.requestOptions.method}\n'
        'headers: ${_formatJson(response.requestOptions.headers)}\n'
        'queryParameters: ${response.requestOptions.queryParameters}\n'
        '--- response ---\n'
        'status code: ${response.statusCode}\n'
        'data: $data';

    _logger.i(message);
  }

  static void logError({
    required StackTrace stackTrace, String? message,
    Object? error,
  }) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static dynamic _formatJson(json) {
    try {
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (_) {
      return json;
    }
  }
}
