import 'package:hive/hive.dart';

import 'manga_database_item_properties.dart';

part 'manga_database_item_title.g.dart';

@HiveType(typeId: 5)
class MangaDatabaseItemTitle extends MangaDatabaseItemProperty {
  MangaDatabaseItemTitle(this.title, this.sourceName);

  @HiveField(0)
  final String sourceName;

  @HiveField(1)
  final String title;

  @override
  String toString() {
    return title.toString();
  }
}
