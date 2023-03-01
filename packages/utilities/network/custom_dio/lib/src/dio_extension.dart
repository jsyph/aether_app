import './interceptors/web_view_interceptor.dart';

import 'interceptors/interceptors.dart';
import 'package:dio/dio.dart';

extension DioInterceptors on Dio {
  Dio withRateLimit(
    int timeBetweenRequestsInSeconds,
  ) =>
      _addUniqueInterceptor(
        RateInterceptor(
          timeBetweenRequestsInSeconds,
        ),
      );

  /// Automatically Bypasses cloudflare ddos protection
  Dio bypassCloudflare() => _addUniqueInterceptor(CloudflareInterceptor());

  /// Gets page content after javascript has ran
  Dio withJavaScriptEnabled() => _addUniqueInterceptor(WebViewInterceptor());

  // Adds interceptor to this
  Dio _addUniqueInterceptor(Interceptor interceptor) {
    // if intercepted is not already added, then add it
    if (!interceptors.contains(interceptor)) {
      return this..interceptors.add(interceptor);
    } 
    // else return same instance without doing anything
    return this;
  }
}
