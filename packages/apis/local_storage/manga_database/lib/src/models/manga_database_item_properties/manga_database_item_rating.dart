import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_rating.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class MangaDatabaseItemRating {
  MangaDatabaseItemRating(this.rating, this.sourceName);

  factory MangaDatabaseItemRating.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemRatingFromJson(json);

  @HiveField(1)
  final double rating;

  @HiveField(0)
  @JsonKey(name:'source_name')
  final String sourceName;

  @override
  String toString() {
    return rating.toString();
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemRatingToJson(this);
}
