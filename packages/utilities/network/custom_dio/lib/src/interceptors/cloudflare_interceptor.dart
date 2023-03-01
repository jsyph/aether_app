import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

//!! Sometimes cloudflare doesn't get bypassed, but it works sometimes ¯\_(ツ)_/¯  
/// Resolves cloudflare protection on website
class CloudflareInterceptor extends Interceptor {
  final logger = Logger();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // exits interceptor if the request method is not `GET`
    if (options.method != 'GET') {
      return handler.next(options);
    }

    // Gets the page content using webview
    final pageContent = await _resolveWithWebView(options.uri);

    // Create response object
    final response = Response(
      requestOptions: options,
      data: pageContent,
      statusCode: 200,
    );

    // Resolve request
    return handler.resolve(response);
  }

// Function takes in the uri of the page and returns the page content
  Future<String> _resolveWithWebView(
    Uri uri,
  ) async {
    logger.d('Using webview to get $uri');

    // Create stream controller to get page content
    final pageContentStreamController = StreamController<String>();

    // Create webview
    final webView = HeadlessInAppWebView(
      initialOptions: InAppWebViewGroupOptions(
        crossPlatform: InAppWebViewOptions(
          // Adds user agent
          userAgent:
              'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:109.0) Gecko/20100101 Firefox/109.0',
        ),
      ),
      initialUrlRequest: URLRequest(url: uri),
      onTitleChanged: (controller, title) async {
        // if title is not `Just a moment...` then return page content
        logger.d(await controller.getHtml());
        if (title != 'Just a moment...') {
          // Once the page stopped loading then, get page html and add it to pageContentStreamController
          final pageHtml = await controller.getHtml();

          return pageContentStreamController.add(pageHtml.toString());
        }

        logger.v('Still waiting to bypass cloudFlare.....');
      },
    );

    // Run the webview
    await webView.run();
    logger.v('Running Webview');

    // Wait until content is available from webview
    final pageContent = await pageContentStreamController.stream.first;
    logger.d('Got page content for $uri');

    // dispose of webview once done
    await webView.dispose();
    logger.v('Disposed of webview');

    return pageContent;
  }
}
