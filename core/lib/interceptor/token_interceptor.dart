

import 'package:core/interceptor/app_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:domain/repositories/repositories.dart';

class TokenInterceptor extends AppInterceptor {
  final TokenRepository _secureStorageRepository;

  TokenInterceptor({
    required TokenRepository secureStorageRepository,
  })  : _secureStorageRepository = secureStorageRepository;

  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorageRepository.getAccessToken();
    if (token?.isNotEmpty ?? false) {
      options.headers.putIfAbsent('Authorization', () => 'Bearer $token');
    }
    await super.onRequest(options, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    switch (err.response?.statusCode) {
      default:
        super.onError(err, handler);
    }
  }
}
