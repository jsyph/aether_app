import 'package:hive/hive.dart';

import 'manga_database_item_properties.dart';

part 'manga_database_item_genres.g.dart';

@HiveType(typeId: 2)
class MangaDatabaseItemGenres extends MangaDatabaseItemProperty {
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
