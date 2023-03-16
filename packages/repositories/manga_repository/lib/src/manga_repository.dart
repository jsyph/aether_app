import 'manga_database.dart';

class MangaRepository {
  static MangaDatabase? _database;

  static MangaDatabase get database => _database!;

  static Future<MangaRepository> initialize() async {
    _database = await MangaDatabase.initialize();
    return MangaRepository();
  }
}
