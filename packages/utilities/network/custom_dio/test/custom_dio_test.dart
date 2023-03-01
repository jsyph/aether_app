import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alfred/alfred.dart';
import 'package:custom_dio/custom_dio.dart';

void main() async {
  setUpAll(() => HttpOverrides.global = null);

  // Create test web server
  final app = Alfred();

  app.get('/*', (req, res) => Directory('test/test_websites'));

  await app.listen(5501);

  final simpleWebpageAddress =
      'http://localhost:${app.server!.port}/simple_website.html';

  final javaScriptWebPageAddress =
      'http://localhost:${app.server!.port}/javascript_website.html';

  test(
    'Test RateLimitInterceptor',
    () async {
      final newDioClient = Dio().withRateLimit(2);
      // start time
      final startTime = DateTime.now().millisecondsSinceEpoch;
      await newDioClient.get(simpleWebpageAddress);
      await newDioClient.get(simpleWebpageAddress);
      final endTime = DateTime.now().millisecondsSinceEpoch;

      final timeDifference = endTime - startTime;

      // Expect that the time difference between the requests is more than 2000 milliseconds
      expect(timeDifference, greaterThanOrEqualTo(2000));
    },
  );

  // Cannot test webview stuff, it doesn't work here, hopefully it works when the app is running ¯\_(ツ)_/¯ 
}
