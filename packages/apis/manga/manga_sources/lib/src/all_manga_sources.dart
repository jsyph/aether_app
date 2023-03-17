import 'dart:async';

import 'package:manga_source_base/manga_source_base.dart';
import 'models/models.dart';
import 'manga_stream/manga_stream.dart';

class AllMangaSources {
  AllMangaSources._();

  static final allSources = [
    AsuraScans(),
    CosmicScans(),
    VoidScans(),
  ];

  static MangaSourceBase getSourceFromString(String sourceName) {
    for (final source in allSources) {
      if (source.runtimeType.toString() == sourceName) {
        return source;
      }
    }
    throw SourceNotFoundError('The source $sourceName is not found');
  }

  static Stream<MangaInfo> getAllManga() async* {
    for (final source in allSources) {
      final mangaInfoStream = source.getAllManga();
      // https://stackoverflow.com/a/56037674/14928208
      await for (final mangaInfo in mangaInfoStream) {
        yield MangaInfo(
          source.runtimeType.toString(),
          mangaInfo,
        );
      }
    }
  }
}

class SourceNotFoundError implements Exception {
  SourceNotFoundError(this.message);

  final String message;
}
