import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'manga_database_item_rating.g.dart';

@HiveType(typeId: 7)
@JsonSerializable()
class MangaDatabaseItemRating extends MangaDatabaseItemProperty {
  MangaDatabaseItemRating(this.rating, super.sourceName);

  factory MangaDatabaseItemRating.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemRatingFromJson(json);

  @HiveField(1)
  final double rating;

  @override
  Map<String, dynamic> toJson() => _$MangaDatabaseItemRatingToJson(this);

  @override
  String toString() {
    return rating.toString();
  }
}
