import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_manga_type.g.dart';

@HiveType(typeId: 5)
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
  unknown,
  @HiveField(4)
  @JsonValue('none')
  none;
}