import 'package:hive/hive.dart';

part 'manga_database_item_genres.g.dart';

@HiveType(typeId: 2)
class MangaDatabaseItemGenres {
  MangaDatabaseItemGenres(this.genres, this.sourceName);

  @HiveField(1)
  final List<String> genres;

  @HiveField(0)
  final String sourceName;

  @override
  String toString() {
    return genres.toString();
  }
}
