import 'recently_updated_manga/recently_updated_manga.dart';
import 'manga_database/manga_database.dart';
import 'manga_search/manga_search.dart';

// exports recently updated manga mixin
export 'recently_updated_manga/recently_updated_manga.dart';

/// Base lass that all manga sources extend
abstract class MangaSource with MangaDatabase, MangaSearch {
  /// Checks if class supports recently updated manga
  bool get supportsRecentlyUpdatedManga => this is RecentlyUpdatedManga;
}

