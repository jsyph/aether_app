import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_description.g.dart';

@HiveType(typeId: 1)
@JsonSerializable()
class MangaDatabaseItemDescription {
  MangaDatabaseItemDescription(this.text, this.sourceName);

  factory MangaDatabaseItemDescription.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemDescriptionFromJson(json);

  @HiveField(0)
  @JsonKey(name:'source_name')
  final String sourceName;

  @HiveField(1)
  final String text;

  @override
  String toString() {
    return text;
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemDescriptionToJson(this);
}
