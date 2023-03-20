import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manga_database_item_status.g.dart';

@HiveType(typeId: 2)
enum MangaDatabaseReleaseStatus {
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

  factory MangaDatabaseReleaseStatus.parse(String rawString) {
    switch (rawString.toLowerCase()) {
      case 'ongoing':
        return MangaDatabaseReleaseStatus.onGoing;

      case 'dropped':
        return MangaDatabaseReleaseStatus.dropped;
      case 'completed':
        return MangaDatabaseReleaseStatus.completed;
      case 'cancelled':
        return MangaDatabaseReleaseStatus.cancelled;
      case 'hiatus':
        return MangaDatabaseReleaseStatus.hiatus;
      default:
        return MangaDatabaseReleaseStatus.unknown;
    }
  }
}
