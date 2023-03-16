import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'manga_database_item_image.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class MangaDatabaseItemCoverImage extends MangaDatabaseItemProperty {
  MangaDatabaseItemCoverImage(this.url, super.sourceName);

  factory MangaDatabaseItemCoverImage.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemCoverImageFromJson(json);

  @HiveField(1)
  final String url;

  @override
  Map<String, dynamic> toJson() => _$MangaDatabaseItemCoverImageToJson(this);

  @override
  String toString() {
    return url.toString();
  }
}
