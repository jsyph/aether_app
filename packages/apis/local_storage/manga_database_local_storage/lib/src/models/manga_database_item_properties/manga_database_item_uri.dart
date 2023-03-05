import 'package:hive/hive.dart';

import 'manga_database_item_properties.dart';

part 'manga_database_item_uri.g.dart';

@HiveType(typeId: 6)
class MangaDatabaseItemUri extends MangaDatabaseItemProperty {
  MangaDatabaseItemUri(this.uri, super.sourceName);

  @HiveField(1)
  final Uri uri;

  @override
  String toString() {
    return uri.toString();
  }
}
