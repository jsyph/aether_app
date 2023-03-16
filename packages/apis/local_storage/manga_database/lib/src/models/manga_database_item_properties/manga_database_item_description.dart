import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'manga_database_item_description.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class MangaDatabaseItemDescription extends MangaDatabaseItemProperty {
  MangaDatabaseItemDescription(this.text, super.sourceName);

  factory MangaDatabaseItemDescription.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemDescriptionFromJson(json);

  @HiveField(1)
  final String text;

  @override
  Map<String, dynamic> toJson() => _$MangaDatabaseItemDescriptionToJson(this);

  @override
  String toString() {
    return text;
  }
}
