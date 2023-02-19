import 'interceptors/interceptors.dart';
import 'package:dio/dio.dart';

extension DioIntercepters on Dio {
  /// Adds Rate interceptor to this
  /// 
  /// Ways to use:
  /// ```dart
  /// // NOTE: 👇 this method is better and less confusing
  /// final dioClient = Dio().withRateLimit(2);
  /// dioClient.get('https://example.com')
  /// // OR
  /// final dioClient = Dio();
  /// dioClient.withRateLimit(2).get('https://example.com`)
  /// ```
  Dio withRateLimit(
    int timeBetweenRequestsInSeconds,
  ) =>
      _addUniqueInterceptor(
        RateInterceptor(
          timeBetweenRequestsInSeconds,
        ),
      );

  /// Addes `UserAgentInterceptor` and `CloudflareInterceptor` interceptor to this
  Dio withVanillaInterceptors() => withCloudflare().withDefaultUserAgent();

  /// Adds Cloudflare intercepter
  Dio withCloudflare() => _addUniqueInterceptor(CloudflareInterceptor());

  /// Adds default user agent intercepters
  Dio withDefaultUserAgent() => _addUniqueInterceptor(UserAgentInterceptor());

  // Adds interceptor to this
  Dio _addUniqueInterceptor(Interceptor interceptor) {
    // if intercepter is not aready added, then add it
    if (!interceptors.contains(interceptor)) {
      return this..interceptors.add(interceptor);
    } 
    // else return same instnace without doing anything
    return this;
  }
}
