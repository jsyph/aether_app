import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_title.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class MangaDatabaseItemTitle {
  MangaDatabaseItemTitle(this.title, this.sourceName);

  factory MangaDatabaseItemTitle.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemTitleFromJson(json);

  @HiveField(0)
  @JsonKey(name:'source_name')
  final String sourceName;

  @HiveField(1)
  final String title;

  @override
  String toString() {
    return title.toString();
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemTitleToJson(this);
}
