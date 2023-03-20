import 'package:dio/dio.dart';
import 'package:custom_dio/custom_dio.dart';
import 'package:manga_source_base/manga_source_base.dart';

class AsuraScans extends MangaStreamTemplate {
  @override
  Dio get dioClient => Dio().withRateLimit(
        Duration(seconds: 5),
      );
  
  @override
  String get mangaListModeUrl => 'https://www.asurascans.com/manga/list-mode/';
}
