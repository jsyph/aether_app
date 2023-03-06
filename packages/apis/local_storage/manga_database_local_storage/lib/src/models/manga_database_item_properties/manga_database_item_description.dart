import 'package:hive/hive.dart';

part 'manga_database_item_description.g.dart';

@HiveType(typeId: 1)
class MangaDatabaseItemDescription {
  MangaDatabaseItemDescription(this.text, this.sourceName);

  @HiveField(0)
  final String sourceName;

  @HiveField(1)
  final String text;

  @override
  String toString() {
    return text;
  }
}
