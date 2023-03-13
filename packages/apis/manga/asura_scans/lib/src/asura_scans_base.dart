import 'package:dio/dio.dart';
import 'package:custom_dio/custom_dio.dart';
import 'package:html/parser.dart';
import 'package:manga_source_base/manga_source_base.dart';

class AsuraScans extends MangaStreamTemplate {
  @override
  Dio get dioClient => Dio().withRateLimit(
        Duration(seconds: 5),
      );

  @override
  Future<List<String>> getAllMangaUrls() async {
    final response =
        await dioClient.get('https://www.asurascans.com/manga/list-mode/');

    final document = parse(response.data);

    final allAElements = document.querySelectorAll('li > a.series');

    final allLinks = allAElements
        .map(
          (e) => e.attributes['href']!,
        )
        .toList();

    return allLinks;
  }
}
