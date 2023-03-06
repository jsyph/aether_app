import 'package:hive/hive.dart';

import 'manga_database_item_properties.dart';

part 'manga_database_item_uri.g.dart';

@HiveType(typeId: 6)
class MangaDatabaseItemUrl extends MangaDatabaseItemProperty {
  MangaDatabaseItemUrl(this.url, this.sourceName);

  @HiveField(0)
  final String sourceName;

  @HiveField(1)
  final String url;

  @override
  String toString() {
    return url.toString();
  }
}
