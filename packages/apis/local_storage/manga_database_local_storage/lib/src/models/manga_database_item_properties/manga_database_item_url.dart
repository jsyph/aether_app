import 'package:hive/hive.dart';

part 'manga_database_item_url.g.dart';

@HiveType(typeId: 6)
class MangaDatabaseItemUrl {
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
