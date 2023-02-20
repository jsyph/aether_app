import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

/// Checks if cloudflare blocked access, if so resolves it using a webview.
class CloudflareInterceptor extends Interceptor {
  final logger = Logger();

  // When cloudflare stop the request, a 403 error is returned, so use webview to get page content
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final response = err.response;

    // if response is null, then return error
    if (response == null) {
      handler.next(err);
    }

    final modifiedResponse = await _resolveWithWebView(response!);

    handler.resolve(modifiedResponse);
  }

  // Function that takes a response and
  // returns a modified response object with its data replaced by the output from the webview
  Future<Response<dynamic>> _resolveWithWebView(
      Response<dynamic> response) async {
    logger.d('Using webview to get ${response.realUri}');

    // Create stream controlller to get page content
    final pageContentStreamController =
        StreamController<String>();

    // Create webview
    final webView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: response.realUri),
      // Cloudflare page title is `Just a moment`, so when it changes then the target page has been loaded
      onTitleChanged: (controller, title) async {
        logger.d('title=$title');
        // Once the page stopped loading then, get page html and add it to pageContentStreamController
        final pageHtml = await controller.getHtml();

        pageContentStreamController.add(pageHtml.toString());
      },
    );

    // Run the webview
    await webView.run();
    logger.v('Running Webview');

    // Wait until content is available from webview
    final pageContent = await pageContentStreamController.stream.first;
    logger.d('Got page content for ${response.realUri}');

    // dispose of webview once done
    await webView.dispose();
    logger.v('Disposed of webview');

    response.data = pageContent;

    return response;
  }
}
