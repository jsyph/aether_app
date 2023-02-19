import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

const _cloudflareServers = ['cloudflare', 'cloudflare-nginx'];

/// Checks if cloudflare blocked access, if so resolves it using a webview.
class CloudflareInterceptor extends Interceptor {
  final logger = Logger();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    // from:
    // https://github.com/tachiyomiorg/tachiyomi/blob/58a0add4f6bd8a5ab1006755035ff1b102355d4a/core/src/main/java/eu/kanade/tachiyomi/network/interceptor/CloudflareInterceptor.kt#L137
    // Checks if `server: cloudflare` or `server: cloudflare-nginx`
    final cloudflareServerHeader = response.headers.value('server');
    logger
        .v('cloudflareServerHeader=$cloudflareServerHeader');

    // If `server` header is not found, or if it doesn't contain cloudflare servers, then stop interception.
    // else continue the processing with webview.
    final useWebView = cloudflareServerHeader == null ||
        !_cloudflareServers.contains(cloudflareServerHeader);
    logger.v('useWebView=$useWebView');
    if (useWebView) {
      logger.d('Not using webview to get ${response.realUri}');
      return handler.next(response);
    }
    logger.d('Using webview to get ${response.realUri}');

    // Create stream controlller to get page content
    final StreamController<String> pageContentStreamController =
        StreamController();

    // Create webview
    final webView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: response.realUri),
      onLoadStop: (controller, url) async {
        // Once the page stopped loading then, get page html and add it to pageContentStreamController
        final pageHtml = await controller.getHtml();
        
        pageContentStreamController.add(pageHtml.toString());
      },
    );

    // Run the webview
    await webView.run();
    logger.v('Running Webview');

    // Wait until content is available from webview
    final pageContent = await pageContentStreamController.stream.last;
    logger.d('Got page content for ${response.realUri}');

    // dispose of webview once done
    await webView.dispose();
    logger.v('Disposed of webview');

    response.data = pageContent;

    logger.d('Exit Insterceptor');
    return handler.next(response);
  }
}
