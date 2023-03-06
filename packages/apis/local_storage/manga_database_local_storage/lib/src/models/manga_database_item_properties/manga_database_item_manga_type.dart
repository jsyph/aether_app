import 'package:hive/hive.dart';

part 'manga_database_item_manga_type.g.dart';

@HiveType(typeId: 7)
enum MangaDatabaseItemMangaType {
  @HiveField(0)
  manhua,
  @HiveField(1)
  manhwa,
  @HiveField(2)
  manga,
  @HiveField(3)
  unknown,
  @HiveField(4)
  none;
}