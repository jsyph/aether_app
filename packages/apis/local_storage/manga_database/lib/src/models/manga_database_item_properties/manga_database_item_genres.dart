import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'manga_database_item_genres.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class MangaDatabaseItemGenres extends MangaDatabaseItemProperty {
  MangaDatabaseItemGenres(this.genres, super.sourceName);

  factory MangaDatabaseItemGenres.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemGenresFromJson(json);

  @HiveField(1)
  final List<String> genres;

  @override
  Map<String, dynamic> toJson() => _$MangaDatabaseItemGenresToJson(this);

  @override
  String toString() {
    return genres.toString();
  }
}
