import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:aether_app/src/core/utilities/network/network.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final dioClient = DioClient();

  setUpAll(() {
    // ↓ required to avoid HTTP error 400 mocked returns
    HttpOverrides.global = null;
  });
  group(
    'Test custom_dio',
    () {
      test(
        'Test Singleton class Creation',
        () {
          final dioClient1 = DioClient();
          final dioClient2 = DioClient();

          // Validate that the 2 dio instances are the same
          expect(
            identical(dioClient1.dioClient, dioClient2.dioClient),
            isTrue,
          );
        },
      );

      group(
        'Test Dio interceptors',
        () {
          test(
            'Test UserAgentInterceptor',
            () async {
              final response =
                  await dioClient.dioClient.get('https://example.com/');
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
        },
      );
    },
  );
}
