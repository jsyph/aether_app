import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aether_app/src/core/utilities/network/network.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final dioClient = Dio().withVanillaInterceptors();

  setUpAll(
    () {
      // ↓ required to avoid HTTP error 400 mocked returns
      HttpOverrides.global = null;
    },
  );

  group(
    'Test custom_dio',
    () {
      group(
        'Test Dio interceptors',
        () {
          test(
            'Test UserAgentInterceptor',
            () async {
              final response = await dioClient.get('https://example.com/');
              // Gets the request headers from the response
              final containsUserAgent =
                  response.requestOptions.headers.containsKey('User-agent');
              // the user agent should be equal to `Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0`
              expect(
                containsUserAgent,
                isTrue,
              );
            },
          );

          test(
            'Test RateLimitInterceptor',
            () async {
              final newDioClient = Dio().withRateLimit(2);
              // start time
              final startTime = DateTime.now().millisecondsSinceEpoch;
              await newDioClient.get('https://example.com/');
              await newDioClient.get('https://example.com/');
              final endTime = DateTime.now().millisecondsSinceEpoch;

              final timeDiffrence = endTime - startTime;

              // Expect that the time diffrence between the requests is more than 2000 milliseconds
              expect(timeDiffrence, greaterThanOrEqualTo(2000));
            },
          );

          // CloudflareInterceptor cannot be tested here as it needs a device with platform channels to run
          // therefore it has been tested manually and it seems to be working... ¯\_(ツ)_/¯
        },
      );
    },
  );
}
