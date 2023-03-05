import 'manga_database_item_properties.dart';
import 'package:hive/hive.dart';

part 'manga_database_item_description.g.dart';

@HiveType(typeId: 1)
class MangaDatabaseItemDescription extends MangaDatabaseItemProperty {
  MangaDatabaseItemDescription(this.text, super.sourceName);

  @HiveField(1)
  final String text;

  @override
  String toString() {
    return text;
  }
}
