import 'package:database_api/database_api.dart';
import 'package:hive/hive.dart';

//!! CURRENT IMPLEMENTATION DOESN'T SAVE THE LAST READ CHAPTER IN DATABASE
class UserLibrary {
  UserLibrary._();

  static late final Box<MangaDatabaseItem> _mangaDb;

  /// initialize user library
  static Future<UserLibrary> initialize() async {
    _mangaDb = await Hive.openBox('user_library');

    return UserLibrary._();
  }

  List<MangaDatabaseItem> get allItems => _mangaDb.toMap().values.toList();

  Future<void> add(MangaDatabaseItem databaseItem) async {
    await _mangaDb.add(databaseItem);
  }

  Future<void> remove(MangaDatabaseItem databaseItem) async {
    for (final keyValue in _mangaDb.toMap().entries) {
      if (keyValue.value == databaseItem) {
        await _mangaDb.delete(keyValue.key);
      }
    }
  }
}
