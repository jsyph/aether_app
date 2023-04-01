import 'package:mangasee_api/src/models/models.dart';
import 'package:mangasee_api/src/webscraper_extension.dart';
import 'package:web_scraper/web_scraper.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';

import 'exceptions.dart';

/// ### Represents the MangaSee aggregator site as a class
///
/// Get the manga database from load
class MangaSeeDataSource {
  MangaSeeDataSource({required this.mangaDatabase}) {
    /// Throw error if the mangaDatabase is empty
    if (mangaDatabase.isEmpty) {
      throw MangaSeeMangaDatabaseConnotBeEmptyException(
          'The `mangaDatabase` argument cannot have a length of 0');
    }
  }

  List<MangaSeeManga> mangaDatabase;

  final _webScraper = WebScraper('https://mangasee123.com');

  /// Searchs MangaSee directory to get manga using fuzzy search
  Future<List<MangaSeeManga>> search({required String query}) async {
    // search in display name
    final topResults = extractTop(
      query: query,
      choices: mangaDatabase,
      limit: 7,
      cutoff: 70,
      getter: (obj) => obj.displayName,
    );

    final results =
        topResults.map((extractionResult) => extractionResult.choice).toList();

    return results;
  }

  /// Search for a manga by using its unique url safe name,
  /// Throws exception if manga is not found as this should not happen normally
  MangaSeeManga searchByUrlSafeName({required String urlSafeName}) {
    for (int i = 0; i < mangaDatabase.length; i++) {
      if (mangaDatabase[i].urlSafeName == urlSafeName) {
        return mangaDatabase[i];
      }
    }

    throw MangaSeeMangaDoesNotExistException(
      'Cannot find $urlSafeName in database',
    );
  }

  /// Returns a list of `MangaSeeChapter`s for a manga using it's url safe name
  /// Throws exception if manga is not found as this should not happen normally
  Future<List<MangaSeeChapter>> getMangaChapters({
    required String urlSafeName,
  }) async {
    if (await _webScraper.loadWebPage('/manga/$urlSafeName')) {
      final chaptersAsJson =
          _webScraper.getListOfMapFromScriptVariable('vm.Chapters');

      if (chaptersAsJson == null) {
        throw MangaSeeMangaDoesNotExistException(
          'Cannot find `$urlSafeName` in database',
        );
      }

      List<MangaSeeChapter> output = [];
      for (int i = 0; i < chaptersAsJson.length; i++) {
        final currentChapter = chaptersAsJson[i];

        output.add(
          MangaSeeChapter.fromJson(
            currentChapter,
            urlSafeName,
          ),
        );
      }

      return output;
    }

    throw MangaSeeConnectionFailureException('Cannot COnnect to MangaSee');
  }

  /// Gets a chapter's pages raw data
  /// throws error if the url is not found
  Future<List<String>> getChapterPages({
    required MangaSeeChapter chapter,
  }) async {
    if (await _webScraper.loadFullURL(chapter.url)) {
      // {
      //   Chapter: "201750",
      //   Type: "Mag Version",
      //   Page: "34",
      //   Directory: "",
      //   Date: "2023-01-12 00:54:12",
      //   ChapterName: null,
      // },
      final currentChapterData =
          _webScraper.getMapFromScriptVariable('vm.CurChapter');

      final hostingServer =
          _webScraper.getStringFromScriptVariable('vm.CurPathName');

      if (currentChapterData == null || hostingServer == null) {
        throw MangaSeeChapterDoesNotExistException(
          'Cannot find the pages for ${chapter.url}',
        );
      }

      List<String> pageUrls = [];

      // do for page count times
      for (int page = 1; page < int.parse(currentChapterData['Page']); page++) {
        final formattedChapterNumber = chapter.chapterNumber.padLeft(4, '0');
        final formattedPageNumber = page.toString().padLeft(3, '0');

        // https://github.com/Hecsall/MAPI/blob/master/lib/services/api.dart#L144
        final directory = currentChapterData['Directory'].isNotEmpty
            ? currentChapterData['Directory'] + '/'
            : '';

        pageUrls.add(
          'https://$hostingServer/manga/${chapter.mangaUrlSafeName}/$directory$formattedChapterNumber-$formattedPageNumber.png',
        );
      }

      return pageUrls;
    }

    throw MangaSeeConnectionFailureException('Cannot Connect to MangaSee');
  }

  /// Gets MangaSee database and returns it
  /// throws error if cannot get database
  static Future<List<MangaSeeManga>> getMangaDatabase() async {
    final internalWebScraper = WebScraper('https://mangasee123.com');

    if (await internalWebScraper.loadWebPage('/search/')) {
      final directoryAsJson =
          internalWebScraper.getListOfMapFromScriptVariable('vm.Directory');

      if (directoryAsJson == null) {
        throw MangaSeeCannotGetDatabaseException(
            'Cannot get database from MangaSee');
      }

      List<MangaSeeManga> output = [];
      for (int i = 0; i < directoryAsJson.length; i++) {
        final mangaSeeManga = MangaSeeManga.fromJson(
          directoryAsJson[i],
        );
        output.add(mangaSeeManga);
      }
      return output;
    }
    throw MangaSeeConnectionFailureException('Cannot Connect to MangaSee');
  }
}
