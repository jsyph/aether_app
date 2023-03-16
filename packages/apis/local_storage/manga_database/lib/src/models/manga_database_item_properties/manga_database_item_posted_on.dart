import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'manga_database_item_posted_on.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class MangaDatabaseItemPostedOn extends MangaDatabaseItemProperty {
  MangaDatabaseItemPostedOn(
    super.sourceName,
    this.postedOn,
  );

  factory MangaDatabaseItemPostedOn.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemPostedOnFromJson(json);

  @HiveField(1)
  @JsonKey(name: 'posted_on')
  final DateTime postedOn;

  /// Connect the generated [_$MangaDatabaseItemPostedOnToJson] function to the `toJson` method.
  @override
  Map<String, dynamic> toJson() => _$MangaDatabaseItemPostedOnToJson(this);
}
