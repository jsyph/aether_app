import 'package:manga_database/manga_database.dart' as db;
import 'package:manga_repository/src/models/models.dart';

class MangaDatabase {
  static List<db.MangaDatabaseItem> _cache = [];
  static db.LocalMangaDatabase? _nullableMangaDb;

  Future<void> loadFromRemote() async {}

  Future<void> exportAsJson(String path) async {}

  Future<List<MangaSearchResult>> fuzzySearch(String query) async {
    final backendSearchResults = await _mangaDb.fuzzyTitleSearch(query);

    _cache.addAll(backendSearchResults);

    List<MangaSearchResult> results = [];

    for (final bResult in backendSearchResults) {
      results.add(
        MangaSearchResult(
          bResult.allTitles,
          bResult.rating.map((e) => e.rating,).toList(),
          bResult.
        ),
      );
    }
  }

  static Future<MangaDatabase> initialize() async {
    _nullableMangaDb = await db.LocalMangaDatabase.initialize();

    return MangaDatabase();
  }

  static db.LocalMangaDatabase get _mangaDb => _nullableMangaDb!;
}
