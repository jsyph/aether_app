import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'manga_database_item_title.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class MangaDatabaseItemTitle extends MangaDatabaseItemProperty {
  MangaDatabaseItemTitle(this.title, super.sourceName);

  factory MangaDatabaseItemTitle.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemTitleFromJson(json);

  @HiveField(1)
  final String title;

  @override
  Map<String, dynamic> toJson() => _$MangaDatabaseItemTitleToJson(this);

  @override
  String toString() {
    return title.toString();
  }
}
