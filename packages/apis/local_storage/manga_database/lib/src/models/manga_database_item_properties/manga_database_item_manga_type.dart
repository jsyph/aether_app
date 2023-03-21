import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_manga_type.g.dart';

@HiveType(typeId: 1)
enum MangaDatabaseItemMangaType {
  @HiveField(0)
  @JsonValue('manhua')
  manhua,
  @HiveField(1)
  @JsonValue('manhwa')
  manhwa,
  @HiveField(2)
  @JsonValue('manga')
  manga,
  @HiveField(3)
  @JsonValue('unknown')
  unknown;

  factory MangaDatabaseItemMangaType.parse(String rawString) {
    switch (rawString.toLowerCase()) {
      case 'manhua':
        return MangaDatabaseItemMangaType.manhua;
      case 'manhwa':
        return MangaDatabaseItemMangaType.manhwa;
      case 'manga':
        return MangaDatabaseItemMangaType.manga;

      default:
        return MangaDatabaseItemMangaType.unknown;
    }
  }
}
