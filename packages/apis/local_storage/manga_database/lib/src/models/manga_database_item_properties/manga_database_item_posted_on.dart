import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_posted_on.g.dart';

@HiveType(typeId: 10)
@JsonSerializable()
class MangaDatabaseItemPostedOn {
  MangaDatabaseItemPostedOn(
    this.sourceName,
    this.postedOn,
  );

  @HiveField(0)
  @JsonKey(name:'posted_on')
  final DateTime postedOn;

  @HiveField(1)
  @JsonKey(name:'source_name')
  final String sourceName;

    factory MangaDatabaseItemPostedOn.fromJson(Map<String, dynamic> json) => _$MangaDatabaseItemPostedOnFromJson(json);

  /// Connect the generated [_$MangaDatabaseItemPostedOnToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MangaDatabaseItemPostedOnToJson(this);
}
