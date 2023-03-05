import 'package:hive/hive.dart';

import 'manga_database_item_properties.dart';

part 'manga_database_item_rating.g.dart';

@HiveType(typeId: 4)
class MangaDatabaseItemRating extends MangaDatabaseItemProperty {
  MangaDatabaseItemRating(this.rating, super.sourceName);

  @HiveField(1)
  final double rating;

  @override
  String toString() {
    return rating.toString();
  }
}
