import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:logger/logger.dart';

class WebViewInterceptor extends Interceptor {
  final logger = Logger();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.d('Getting page using webview for ${options.uri.toString()}');

    // Exit interceptor IF the request method is not `GET`
    if (options.method != 'GET') {
      return handler.next(options);
    }

    // Stream controller to get page content
    final pageContentStreamController = StreamController<String>();

    // Create webview
    final webView = HeadlessInAppWebView(
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          userAgent:
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0',
        ),
      ),
      initialUrlRequest: URLRequest(
        url: options.uri,
        body: options.data,
        headers: Map<String, String>.from(options.headers),
        method: options.method,
      ),
      onLoadStop: (controller, url) async {
        // get page content
        final pageContent = await controller.getHtml();
        // Add page content to stream controller
        pageContentStreamController.add(pageContent.toString());
      },
    );

    // run webview
    logger.v('Running WebView');
    await webView.run();

    // convert stream to future, and await results
    // Returns the first item from stream
    final pageContent = await pageContentStreamController.stream.first;
    logger.d('Got Page Content');

    // dispose of webview
    logger.v('Disposing of WebView');
    await webView.dispose();

    // create response object
    final response = Response(
      requestOptions: options,
      data: pageContent,
      headers: Headers.fromMap(
        Map<String, List<String>>.from(options.headers),
      ),
      statusCode: 200,
    );

    // Resolve the request
    logger.v('Resolved request');
    return handler.resolve(response);
  }
}
