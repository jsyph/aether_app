import 'package:custom_dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:manga_source_base/manga_source_base.dart';

class VoidScans extends MangaStreamTemplate {
  @override
  Uri get baseUri => Uri.parse('https://void-scans.com');

  @override
  Dio get dioClient => Dio().withRateLimit(
        Duration(seconds: 5),
      );
}
