import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_property.g.dart';

@HiveType(typeId: 1)
@JsonSerializable(disallowUnrecognizedKeys: true)
class MangaDatabaseItemProperty {
  MangaDatabaseItemProperty(this.sourceName);

  factory MangaDatabaseItemProperty.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemPropertyFromJson(json);

  @HiveField(0)
  @JsonKey(name: 'source_name')
  final String sourceName;

  Map<String, dynamic> toJson() => _$MangaDatabaseItemPropertyToJson(this);
}
