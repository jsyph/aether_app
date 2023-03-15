import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_image.g.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class MangaDatabaseItemCoverImage {
  MangaDatabaseItemCoverImage(this.url, this.sourceName);

  factory MangaDatabaseItemCoverImage.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemCoverImageFromJson(json);

  @HiveField(0)
  @JsonKey(name:'source_name')
  final String sourceName;

  @HiveField(1)
  final String url;

  @override
  String toString() {
    return url.toString();
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemCoverImageToJson(this);
}
