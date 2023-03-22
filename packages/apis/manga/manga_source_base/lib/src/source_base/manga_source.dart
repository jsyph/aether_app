import 'dart:async';

import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import '../../manga_source_base.dart';
import 'manga_chapter_methods.dart.dart';

import 'manga_information_methods.dart';

/// Base lass that all manga sources extend
abstract class MangaSource
    with MangaInformationAbstractMethods, MangaChapterAbstractMethods {
  final _logger = AppLogger();

  Future<List<MangaChapter>> getChapters(String mangaUrl) async {
    final response = await dioClient.get(mangaUrl);
    final document = parse(response.data);

    final allUrlsElements = document.querySelectorAll(mangaChapterUrlSelector);

    final allTitlesElements =
        document.querySelectorAll(mangaChapterTitleSelector);

    final allChapterDateElements =
        document.querySelectorAll(mangaChapterDateSelector);

    final allChapterNumbers =
        document.querySelectorAll(mangaChapterNumberSelector);

    List<MangaChapter> chapters = [];

    for (int i = 0; i < allUrlsElements.length; i++) {
      final unProcessedChapterNumber =
          mangaChapterExtractChapterNumber(allChapterNumbers[i]);

      late final double? parsedDouble;
      if (unProcessedChapterNumber == null) {
        parsedDouble = null;
      } else {
        parsedDouble = double.tryParse(unProcessedChapterNumber);
      }

      chapters.add(
        MangaChapter(
          allTitlesElements[i].text,
          allUrlsElements[i].attributes['href']!,
          mangaChapterDateFormat.parse(
            mangaChapterExtractChapterDate(allChapterDateElements[i]),
          ),
          parsedDouble,
        ),
      );
    }

    return chapters;
  }

  Dio get dioClient;

  /// Checks if class supports recently updated manga
  bool get supportsRecentlyUpdatedManga => this is RecentlyUpdatedManga;

  // Returns stream of MangaInformation as they are loaded
  Stream<MangaInformation> getAllManga() async* {
    final allMangaUrls = await getAllMangaUrls();
    _logger.i('Source has ${allMangaUrls.length} series');

    for (final url in allMangaUrls) {
      _logger.i('Getting $url');
      final response = await dioClient.get(url);

      _logger.v('Got response ${response.statusCode}');

      final parsedDocument = parse(response.data);

      _logger.v('finished parsing document');

      final parsedResult = processMangaInformation(parsedDocument, url);

      _logger.v(parsedResult);

      _logger.i('yielding $url data');

      yield parsedResult;
    }
  }

  Uri get baseUri;

  /// Gets all manga urls from source
  Future<List<String>> getAllMangaUrls();

  /// Returns stream of mangaInformation one by one
  Stream<MangaInformation> getRecentlyAddedManga();

  MangaInformation processMangaInformation(
      Document parsedDocument, String url) {
    // ─────────────────────────────────────────────────────────────

    // title element should not be null
    final title = mangaInfoExtractTitle(parsedDocument).trim();

    // ─────────────────────────────────────────────────────────────

    List<String>? unTrimmedAltTitles =
        mangaInfoExtractAltTitles(parsedDocument);

    late final List<String>? altTitles;
    if (unTrimmedAltTitles != null) {
      altTitles = unTrimmedAltTitles.map((e) => e.trim()).toList();
    } else {
      altTitles = null;
    }

    // ─────────────────────────────────────────────────────────────

    final rating = mangaInfoExtractRating(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final status = mangaInfoExtractStatus(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final genres = mangaInfoExtractGenres(parsedDocument)
        .map(
          (e) => e.trim(),
        )
        .toList();

    // ─────────────────────────────────────────────────────────────

    final description = mangaInfoExtractDescription(parsedDocument).trim();

    // ─────────────────────────────────────────────────────────────

    final coverImageUrl = mangaInfoExtractCoverImageUrl(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final unTrimmedAuthor = mangaInfoExtractAuthor(parsedDocument);
    late final String? author;
    if (unTrimmedAuthor != null) {
      author = unTrimmedAuthor.trim();
    } else {
      author = null;
    }
    // ─────────────────────────────────────────────────────────────

    final dateReleasedOn = mangaInfoExtractDateReleasedOn(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    final contentType = mangaInfoExtractContentType(parsedDocument);

    // ─────────────────────────────────────────────────────────────

    return MangaInformation(
      title: title,
      altTitles: altTitles,
      description: description,
      genres: genres,
      rating: rating,
      coverImageUrl: coverImageUrl,
      releaseStatus: status,
      contentType: contentType,
      author: author,
      datePostedOn: dateReleasedOn,
      url: url,
    );
  }

  Future<List<String>> getChapterImages(String chapterUrl) async {
    final response = await dioClient.get(chapterUrl);

    final parsedDocument = parse(response.data);

    final allChapterImageElements =
        parsedDocument.querySelectorAll(chapterImageSelector);

    return allChapterImageElements
        .map(
          (e) => e.attributes['src']!,
        )
        .toList();
  }

  String get chapterImageSelector;
}
