import 'package:dio/dio.dart';

/// Limits the number of requests sent by the dio client
/// 
class RateInterceptor extends Interceptor {
  int? timeSinceLastRequest;
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // if `timeSinceLastRequest` is null, then assign it
    timeSinceLastRequest ??= DateTime.now().millisecondsSinceEpoch;

    // if time since last reqest
  }
}