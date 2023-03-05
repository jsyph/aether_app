import 'package:hive/hive.dart';

import 'manga_database_item_properties.dart';

part 'manga_database_item_image.g.dart';

@HiveType(typeId: 3)
class MangaDatabaseItemCoverImage extends MangaDatabaseItemProperty {
  MangaDatabaseItemCoverImage(this.uri, super.sourceName);

  @HiveField(1)
  final Uri uri;

  @override
  String toString() {
    return uri.toString();
  }
}
