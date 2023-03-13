import 'dart:io';

import 'package:alfred/alfred.dart';
import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';
import 'package:manga_source_base/manga_source_base.dart';
import 'package:manga_source_base/src/source_templates/manga_stream.dart';
import 'package:test/test.dart';

void main() async {
  final app = Alfred();

  /// Note the wildcard (*) this is very important!!
  app.get('/*', (req, res) => Directory('./test/test_manga_template/'));

  await app.listen();

  group(
    'Test Source Templates',
    () {
      group(
        'MangaStream template',
        () {
          group(
            'Test getMangaInformation',
            () {
              test(
                'Test without author',
                () async {
                  final testClass = MangaStreamTestClass(
                    [
                      'http://localhost:3000/manga_stream/manga_information/test_site_1.html',
                      'http://localhost:3000/manga_stream/manga_information/test_site_2.html',
                      'http://localhost:3000/manga_stream/manga_information/test_site_3.html',
                      'http://localhost:3000/manga_stream/manga_information/test_site_4.html',
                      'http://localhost:3000/manga_stream/manga_information/test_site_5.html',
                      'http://localhost:3000/manga_stream/manga_information/test_site_6.html',
                      'http://localhost:3000/manga_stream/manga_information/test_site_7.html',
                      'http://localhost:3000/manga_stream/manga_information/test_site_8.html',
                    ],
                  );

                  final expectedTestResults = [
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNull,
                      'altTitles': isNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNull,
                      'altTitles': isNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNull,
                      'altTitles': isNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNull,
                      'altTitles': isNotNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNotNull,
                      'altTitles': isNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNotNull,
                      'altTitles': isNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNotNull,
                      'altTitles': isNotNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNotNull,
                      'altTitles': isNotNull,
                    },
                    {
                      'title': isNotNull,
                      'releaseStatus': isNotNull,
                      'rating': isNotNull,
                      'genres': isNotNull,
                      'description': isNotNull,
                      'dateReleasedOn': isNotNull,
                      'coverImageUrl': isNotNull,
                      'contentType': isNotNull,
                      'author': isNotNull,
                      'altTitles': isNotNull,
                    },
                  ];

                  final mangaInfos = await testClass.getAllManga().toList();

                  for (int i = 0; i < mangaInfos.length; i++) {
                    expect(
                      mangaInfos[i].title,
                      expectedTestResults[i]['title'],
                    );
                    expect(
                      mangaInfos[i].releaseStatus,
                      expectedTestResults[i]['releaseStatus'],
                    );
                    expect(
                      mangaInfos[i].rating,
                      expectedTestResults[i]['rating'],
                    );
                    expect(
                      mangaInfos[i].genres,
                      expectedTestResults[i]['genres'],
                    );
                    expect(
                      mangaInfos[i].description,
                      expectedTestResults[i]['description'],
                    );
                    expect(
                      mangaInfos[i].dateReleasedOn,
                      expectedTestResults[i]['dateReleasedOn'],
                    );
                    expect(
                      mangaInfos[i].coverImageUrl,
                      expectedTestResults[i]['coverImageUrl'],
                    );
                    expect(
                      mangaInfos[i].contentType,
                      expectedTestResults[i]['contentType'],
                    );
                    expect(
                      mangaInfos[i].author,
                      expectedTestResults[i]['author'],
                    );
                    expect(
                      mangaInfos[i].altTitles,
                      expectedTestResults[i]['altTitles'],
                    );
                  }
                },
              );
            },
          );
        },
      );
    },
  );
}

class MangaStreamTestClass extends MangaStreamTemplate {
  MangaStreamTestClass(this.testUrls);

  final List<String> testUrls;

  @override
  Dio get dioClient => Dio();

  @override
  Future<List<String>> getAllMangaUrls() {
    return Future.value(testUrls);
  }
}
