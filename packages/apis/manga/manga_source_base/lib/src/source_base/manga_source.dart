import 'dart:async';

import 'package:app_logging/app_logging.dart';
import 'package:dio/dio.dart';
import 'package:html/parser.dart';
import 'manga_information_mixin.dart';
import 'models/models.dart';
import 'package:compute/compute.dart';

import '../recently_updated_manga/recently_updated_manga.dart';

/// Base lass that all manga sources extend
abstract class MangaSourceBase with MangaInformationMixin {
  final _logger = AppLogger();

  /// Checks if class supports recently updated manga
  bool get supportsRecentlyUpdatedManga => this is RecentlyUpdatedManga;

  /// Gets all manga urls from source
  Future<List<String>> getAllMangaUrls();

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

      final parsedResult = await compute(
        (document) => extractMangaInformation(document),
        parsedDocument,
      );

      _logger.v(parsedResult);

      _logger.i('yielding $url data');

      yield parsedResult;
    }
  }

  Dio get dioClient;
}
