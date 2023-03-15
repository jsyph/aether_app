import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
part 'manga_database_item_genres.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class MangaDatabaseItemGenres {
  MangaDatabaseItemGenres(this.genres, this.sourceName);

  factory MangaDatabaseItemGenres.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemGenresFromJson(json);

  @HiveField(1)
  final List<String> genres;

  @HiveField(0)
  @JsonKey(name:'source_name')
  final String sourceName;

  @override
  String toString() {
    return genres.toString();
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemGenresToJson(this);
}
