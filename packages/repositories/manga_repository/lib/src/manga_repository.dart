import 'package:app_logging/app_logging.dart';
import 'package:manga_database/manga_database.dart';
import 'package:manga_sources/manga_sources.dart';
import 'package:matrix2d/matrix2d.dart';

import 'database_methods.dart';
import 'models/models.dart';

class MangaRepository {
  MangaRepository._();

  final database = DatabaseFunctions(_mangaDb);

  static List<List<MangaChapter>> _mangaChaptersCache = [];
  static LocalMangaDatabase? _nullableMangaDb;

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

    _mangaChaptersCache = transposedChapterArrayWithoutNull;

    return MangaInformationPage(
      chapters: transposedChapterArrayWithoutNull,
      information: allMangaInformation,
    );
  }

  Future<MangaChapterPage> getMangaChapterPage(
      int chapterIndex, String sourceName) async {
    final currentChapter = _mangaChaptersCache[chapterIndex].firstWhere(
      (element) => element.sourceName == sourceName,
      // if no source is found then use the first source at chapterIndex
      orElse: () => _mangaChaptersCache[chapterIndex].first,
    );

    //  the same chapter but from another source
    final otherSourceCurrentChapter = _mangaChaptersCache[chapterIndex]
        .where(
          (element) => element.sourceName != currentChapter.sourceName,
        )
        .toList();

    late final int? nextChapterIndex;

    try {
      _mangaChaptersCache[chapterIndex + 1];
      nextChapterIndex = chapterIndex + 1;
    } catch (e) {
      nextChapterIndex = null;
    }

    late final int? previousChapterIndex;
    try {
      _mangaChaptersCache[chapterIndex - 1];
      previousChapterIndex = chapterIndex - 1;
    } catch (e) {
      previousChapterIndex = null;
    }

    final source =
        AllMangaSources.getSourceFromString(currentChapter.sourceName);

    final chapterImages = await source.getChapterImages(currentChapter.url);

    return MangaChapterPage(
      nextChapterIndex,
      previousChapterIndex,
      chapterImages,
      currentChapter,
      otherSourceCurrentChapter,
    );
  }

  static Future<MangaRepository> initialize() async {
    _nullableMangaDb = await LocalMangaDatabase.initialize();
    return MangaRepository._();
  }

  static registerDatabaseAdapters() {
    LocalMangaDatabase.registerHiveAdapters();
  }

  static LocalMangaDatabase get _mangaDb => _nullableMangaDb!;
}
