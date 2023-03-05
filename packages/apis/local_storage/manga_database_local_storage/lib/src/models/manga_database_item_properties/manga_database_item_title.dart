import 'package:hive/hive.dart';

import 'manga_database_item_properties.dart';

part 'manga_database_item_title.g.dart';

@HiveType(typeId: 5)
class MangaDatabaseItemTitles extends MangaDatabaseItemProperty {
  MangaDatabaseItemTitles(this.titles, this.sourceName);

  @HiveField(0)
  final String sourceName;

  @HiveField(1)
  final List<String> titles;

  @override
  String toString() {
    return titles.toString();
  }
}
