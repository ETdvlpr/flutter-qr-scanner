import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scanner/utils/constants.dart';

class AuthorizationInterceptor extends InterceptorsWrapper {
  final String accessToken;
  final Dio dio;

  AuthorizationInterceptor(this.dio, this.accessToken);

  @override
  Future onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final authToken = await GetStorage().read(kAccessTokenKey);
    log("url: ${options.baseUrl}${options.path}");
    if (options.data != null) {
      try {
        options.headers['Authorization'] = "Basic $authToken";
        log("data: ${jsonEncode(options.data)}");
      } catch (e) {
        log('$e');
      }
    }
    return handler.next(options);
  }
}

class RetryInterceptor extends Interceptor {
  int maxRetry;
  final Dio dio;

  RetryInterceptor(this.dio, {this.maxRetry = 3});

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      if (maxRetry > 0) {
        maxRetry--;
        return _retry(err.requestOptions, handler);
      }
    }
    return handler.next(err);
  }

  Future _retry(
      RequestOptions requestOptions, ErrorInterceptorHandler handler) {
    return dio
        .request(
          requestOptions.path,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          queryParameters: requestOptions.queryParameters,
          options: Options(method: requestOptions.method),
        )
        .then((value) => handler.resolve(value),
            onError: (e) => handler.reject(e));
  }
}
