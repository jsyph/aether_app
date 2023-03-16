import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'manga_database_item_url.g.dart';

@HiveType(typeId: 11)
@JsonSerializable()
class MangaDatabaseItemUrl extends MangaDatabaseItemProperty {
  MangaDatabaseItemUrl(this.url, super.sourceName);

  factory MangaDatabaseItemUrl.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemUrlFromJson(json);

  @HiveField(1)
  final String url;

  @override
  Map<String, dynamic> toJson() => _$MangaDatabaseItemUrlToJson(this);

  @override
  String toString() {
    return url.toString();
  }
}
