import 'package:custom_dio/custom_dio.dart';
import 'package:dio/dio.dart';
import 'package:manga_source_base/manga_source_base.dart';

class CosmicScans extends MangaStreamTemplate {
  @override
  Dio get dioClient => Dio().withRateLimit(
        Duration(seconds: 5),
      );

  @override
  String get mangaListModeUrl => 'https://cosmicscans.com/manga/list-mode/';
}
