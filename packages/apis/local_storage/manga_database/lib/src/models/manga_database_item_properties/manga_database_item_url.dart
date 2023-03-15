import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_url.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class MangaDatabaseItemUrl {
  MangaDatabaseItemUrl(this.url, this.sourceName);

  factory MangaDatabaseItemUrl.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemUrlFromJson(json);

  @HiveField(0)
  @JsonKey(name:'source_name')
  final String sourceName;

  @HiveField(1)
  final String url;

  @override
  String toString() {
    return url.toString();
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemUrlToJson(this);
}
