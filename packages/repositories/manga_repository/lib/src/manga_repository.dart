import 'package:app_logging/app_logging.dart';
import 'package:manga_database/manga_database.dart';
import 'package:manga_sources/manga_sources.dart';
import 'package:matrix2d/matrix2d.dart';

import 'models/models.dart';

class MangaRepository {
  MangaRepository._();

  static LocalMangaDatabase? _nullableMangaDb;

  // Future<void> exportAsJson(String path) async {}

  Stream<MangaInformation> downloadMangaDatabase() async* {
    final allMangaStream = AllMangaSources.getAllManga();

    await for (final mangaData in allMangaStream) {
      final mangaInformation = MangaInformation(
        altTitles: mangaData.info.altTitles,
        author: mangaData.info.author,
        contentType:
            MangaContentType.parse(mangaData.info.contentType.toString()),
        coverImageUrl: mangaData.info.coverImageUrl,
        datePostedOn: mangaData.info.datePostedOn,
        description: mangaData.info.description,
        genres: mangaData.info.genres,
        rating: mangaData.info.rating,
        releaseStatus:
            MangaReleaseStatus.parse(mangaData.info.releaseStatus.toString()),
        sourceName: mangaData.sourceName,
        title: mangaData.info.title,
        url: mangaData.info.url,
      );

      _mangaDb.addManga(
        sourceName: mangaInformation.sourceName,
        title: mangaInformation.title,
        altTitles: mangaInformation.altTitles,
        description: mangaInformation.description,
        genres: mangaInformation.genres,
        rating: mangaInformation.rating,
        url: mangaInformation.url,
        coverImageUrl: mangaInformation.coverImageUrl,
        contentType: mangaInformation.contentType.toString(),
        author: mangaInformation.author,
        datePostedOn: mangaInformation.datePostedOn,
        releaseStatus: mangaInformation.releaseStatus.toString(),
      );
    }
  }

  // Future<void> loadFromRemote() async {}

  Future<List<MangaSearchResult>> fuzzySearch(String query) async {
    final fuzzySearchResults = await _mangaDb.fuzzyTitleSearch(query);

    List<MangaSearchResult> searchResults = [];
    for (final fuzzySearchResult in fuzzySearchResults) {
      searchResults.add(
        MangaSearchResult(
          // currently it sets the first title added to record as the title returned
          fuzzySearchResult.titles,
          fuzzySearchResult.coverImages,
          fuzzySearchResult.rating,
          fuzzySearchResult.altTitles,
        ),
      );
    }

    return searchResults;
  }

  /// Get the manga information page that contains all manga information and all chapters in a vector
  Future<MangaInformationPage> getMangaInformationPage(String mangaId) async {
    final searchResult = await _mangaDb.getMangaById(mangaId);

    List<MangaInformation> allMangaInformation = [];

    final searchResultsFiltered = searchResult.toList();

    for (final filteredResult in searchResultsFiltered) {
      final mangaInformation = MangaInformation(
        altTitles: filteredResult.altTitles,
        author: filteredResult.author,
        contentType: MangaContentType.parse(
          filteredResult.contentType.toString(),
        ),
        coverImageUrl: filteredResult.coverImage,
        datePostedOn: filteredResult.postedOn,
        description: filteredResult.description,
        genres: filteredResult.genres,
        rating: filteredResult.rating,
        releaseStatus: MangaReleaseStatus.parse(
          filteredResult.releaseStatus.toString(),
        ),
        sourceName: filteredResult.sourceName,
        title: filteredResult.title,
        url: filteredResult.url,
      );

      allMangaInformation.add(mangaInformation);
    }

    // [
    //    [mangaChapter1a, mangaChapter2a, mangaChapter3a, mangaChapter4a],
    //    [mangaChapter1b, mangaChapter2b, mangaChapter3b, mangaChapter4b],
    // ]
    // should become:
    // [
    //   [mangaChapter1a, mangaChapter1b],
    //   [mangaChapter2a, mangaChapter2b],
    //   [mangaChapter3a, mangaChapter3b],
    //   [mangaChapter4a, mangaChapter4b]
    // ]
    List<List<MangaChapter>> allMangaChapters = [];

    for (int i = 0; i < searchResult.sourceNames.length; i++) {
      final source =
          AllMangaSources.getSourceFromString(searchResult.sourceNames[i]);

      final chapterUrl = searchResultsFiltered[i].url;

      final allChapters = await source.getChapters(chapterUrl);

      final allParsedChapters = allChapters
          .map(
            (chapter) => MangaChapter(
              chapter.title,
              chapter.url,
              chapter.number,
              chapter.timeReleased,
              searchResult.sourceNames[i],
            ),
          )
          .toList();

      allMangaChapters.add(allParsedChapters);
    }

    // get longest List in 2d array
    int longestListLength = 0;
    for (final mangaChapters in allMangaChapters) {
      if (mangaChapters.length > longestListLength) {
        longestListLength = mangaChapters.length;
      }
    }

    // if array length is not the same as longest array length,
    // then add null to list until it has the same length as the largest list
    // This is to make the arrays even to enable transposition
    List<List<MangaChapter?>> evenAllMangaChapters = [];
    for (final mangaChapters in allMangaChapters) {
      if (mangaChapters.length < longestListLength) {
        List<MangaChapter?> modifiedMangaChapters =
            List<MangaChapter?>.from(mangaChapters);

        modifiedMangaChapters.length = longestListLength;

        evenAllMangaChapters.add(modifiedMangaChapters);
      } else {
        evenAllMangaChapters.add(mangaChapters);
      }
    }

    // transpose array
    final transposedChapterArray = Matrix2d()
        .transpose(evenAllMangaChapters)
        // convert List<dynamic> to List<List<MangaChapter>>
        .map(
          (e) => (e as List).map((e) => e as MangaChapter?).toList(),
        )
        .toList();

    // remove null values from the array
    final transposedChapterArrayWithoutNull = transposedChapterArray
        .map(
          (transposedMangaChapter) =>
              transposedMangaChapter.whereType<MangaChapter>().toList(),
        )
        .toList();

    AppLogger().d(transposedChapterArrayWithoutNull);

    return MangaInformationPage(
      chapters: transposedChapterArrayWithoutNull,
      information: allMangaInformation,
    );
  }

  static Future<MangaRepository> initialize() async {
    _nullableMangaDb = await LocalMangaDatabase.initialize();
    return MangaRepository._();
  }

  static LocalMangaDatabase get _mangaDb => _nullableMangaDb!;
}
