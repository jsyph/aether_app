import 'package:dio/dio.dart';

/// Adds User agent header to outgoing requests
class UserAgentInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // If a user agent has not been set, then it sets it
    if (!options.headers.containsKey('User-Agent')) {
      options.headers.addAll(
        {
          'User-Agent':
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0',
        },
      );
    }
    return handler.next(options);
  }
}
