import 'interceptors/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart'
    as dio_cookie_manager;
import 'package:cookie_jar/cookie_jar.dart';

class DioClient {
  factory DioClient() {
    return _customDio;
  }

  DioClient._();

  static final CookieJar cookieJar = CookieJar();

  static final Dio _client = _addVanillaInterceptors(Dio());
  static final DioClient _customDio = DioClient._();

  /// Return Singleton instance of client with all interceptors attached
  Dio get dioClient => _client;

  Dio rateLimitedDioClient() => _client;

  // add interceptors to dio instance and return it
  static Dio _addVanillaInterceptors(Dio dio) {
    return dio
      ..interceptors.addAll(
        [
          // onRequest
          UserAgentInterceptor(),
          dio_cookie_manager.CookieManager(cookieJar),
          // OnResponse
          CloudflareInterceptor(),
        ],
      );
  }
}


