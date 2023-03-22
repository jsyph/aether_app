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

  app.get(
    '/manga',
    (req, res) async {
      final pageNumber = req.uri.queryParameters['page'];
      AppLogger().d('Alfred: Page number is $pageNumber');
      res.headers.contentType = ContentType.html;
      return File(
          './test/test_manga_template/manga_stream/recently_added_manga/test_site_$pageNumber.html');
    },
  );

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
                'Test MangaStream',
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
                      mangaInfos[i].datePostedOn,
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

          test(
            'Test Get recently updated manga',
            () async {
              final testClass = MangaStreamTestClass([]);

              final recentlyAddedMangaStream =
                  testClass.getRecentlyAddedManga();

              int count = 0;
              List<MangaInformation> outputList = [];

              await for (final recentlyAddedManga in recentlyAddedMangaStream) {
                outputList.add(recentlyAddedManga);

                // waits for the 2 item
                if (count == 1) {
                  expect(outputList.length, equals(2));

                  break;
                }
                count++;
              }
            },
          );

          test(
            'Test getChapterImages',
            () async {
              final testClass = MangaStreamTestClass([]);

              final testSites = [
                'http://localhost:3000/manga_stream/chapter_images/test_site_1.html',
                'http://localhost:3000/manga_stream/chapter_images/test_site_2.html',
                'http://localhost:3000/manga_stream/chapter_images/test_site_3.html',
              ];

              final expectedNumberOfImages = [14, 10, 19];
              for (int i = 0; i < testSites.length; i++) {
                final allImages =
                    await testClass.getChapterImages(testSites[i]);

                expect(
                  allImages.length,
                  equals(
                    expectedNumberOfImages[i],
                  ),
                );
              }
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
  Uri get baseUri => Uri.parse('http://localhost:3000');

  @override
  Dio get dioClient => Dio();

  @override
  Future<List<String>> getAllMangaUrls() {
    return Future.value(testUrls);
  }
}
