import 'package:hive/hive.dart';

part 'manga_database_item_property.g.dart';

@HiveType(typeId: 0)
class MangaDatabaseItemProperty {
  MangaDatabaseItemProperty(this.sourceName);

  @HiveField(0)
  final String sourceName;

  @override
  String toString() {
    return sourceName;
  }
}
