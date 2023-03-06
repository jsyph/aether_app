import 'package:hive/hive.dart';

part 'manga_database_item_rating.g.dart';

@HiveType(typeId: 4)
class MangaDatabaseItemRating {
  MangaDatabaseItemRating(this.rating, this.sourceName);

  @HiveField(0)
  final String sourceName;

  @HiveField(1)
  final double rating;

  @override
  String toString() {
    return rating.toString();
  }
}
