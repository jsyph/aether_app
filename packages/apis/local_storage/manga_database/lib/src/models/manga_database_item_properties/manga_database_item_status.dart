import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_status.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class MangaDatabaseItemReleaseStatus {
  MangaDatabaseItemReleaseStatus(
    this.status,
    this.sourceName,
  );

  factory MangaDatabaseItemReleaseStatus.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemReleaseStatusFromJson(json);

  @HiveField(0)
  @JsonKey(name: 'source_name')
  final String sourceName;

  @HiveField(1)
  final ReleaseStatus status;

  /// Connect the generated [_$MangaDatabaseItemReleaseStatusToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MangaDatabaseItemReleaseStatusToJson(this);
}

@HiveType(typeId: 9)
enum ReleaseStatus {
  @HiveField(0)
  @JsonValue('on_going')
  onGoing,

  @HiveField(1)
  @JsonValue('dropped')
  dropped,

  @HiveField(2)
  @JsonValue('completed')
  completed,

  @HiveField(3)
  @JsonValue('cancelled')
  cancelled,

  @HiveField(4)
  @JsonValue('hiatus')
  hiatus,

  @HiveField(5)
  @JsonValue('unknown')
  unknown,

  @HiveField(6)
  @JsonValue('none')
  none;

  factory ReleaseStatus.parse(String rawString) {
    switch (rawString.toLowerCase()) {
      case 'ongoing':
        return ReleaseStatus.onGoing;

      case 'dropped':
        return ReleaseStatus.dropped;
      case 'completed':
        return ReleaseStatus.completed;
      case 'cancelled':
        return ReleaseStatus.cancelled;
      case 'hiatus':
        return ReleaseStatus.hiatus;
      default:
        return ReleaseStatus.unknown;
    }
  }
}
