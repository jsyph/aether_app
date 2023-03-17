import 'package:dio/dio.dart';
import 'package:custom_dio/custom_dio.dart';
import 'package:html/parser.dart';
import 'package:manga_source_base/manga_source_base.dart';

class VoidScans extends MangaStreamTemplate {
  @override
  Dio get dioClient => Dio().withRateLimit(
        Duration(seconds: 5),
      );

  @override
  Future<List<String>> getAllMangaUrls() async {
    List<String> allMangaUrls = [];

    int pageNumber = 1;

    while (true) {
      final response = await dioClient
          .get('https://void-scans.com/projects/page/$pageNumber/');
      final document = parse(response.data);

      final allUrls = document
          .querySelectorAll('div.bsx > a')
          .map((e) => e.attributes['href']!);

      allMangaUrls.addAll(allUrls);

      final nextPageElement = document.querySelector('a.next.page-numbers');

      if (nextPageElement == null) {
        break;
      }

      pageNumber++;
    }

    return allMangaUrls;
  }
}
