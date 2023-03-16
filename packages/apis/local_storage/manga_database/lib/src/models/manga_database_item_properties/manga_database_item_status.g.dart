// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemReleaseStatusAdapter
    extends TypeAdapter<MangaDatabaseItemReleaseStatus> {
  @override
  final int typeId = 8;

  @override
  MangaDatabaseItemReleaseStatus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemReleaseStatus(
      fields[1] as ReleaseStatus,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemReleaseStatus obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.status)
      ..writeByte(0)
      ..write(obj.sourceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemReleaseStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ReleaseStatusAdapter extends TypeAdapter<ReleaseStatus> {
  @override
  final int typeId = 9;

  @override
  ReleaseStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ReleaseStatus.onGoing;
      case 1:
        return ReleaseStatus.dropped;
      case 2:
        return ReleaseStatus.completed;
      case 3:
        return ReleaseStatus.cancelled;
      case 4:
        return ReleaseStatus.hiatus;
      case 5:
        return ReleaseStatus.unknown;
      case 6:
        return ReleaseStatus.none;
      default:
        return ReleaseStatus.onGoing;
    }
  }

  @override
  void write(BinaryWriter writer, ReleaseStatus obj) {
    switch (obj) {
      case ReleaseStatus.onGoing:
        writer.writeByte(0);
        break;
      case ReleaseStatus.dropped:
        writer.writeByte(1);
        break;
      case ReleaseStatus.completed:
        writer.writeByte(2);
        break;
      case ReleaseStatus.cancelled:
        writer.writeByte(3);
        break;
      case ReleaseStatus.hiatus:
        writer.writeByte(4);
        break;
      case ReleaseStatus.unknown:
        writer.writeByte(5);
        break;
      case ReleaseStatus.none:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReleaseStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaDatabaseItemReleaseStatus _$MangaDatabaseItemReleaseStatusFromJson(
        Map<String, dynamic> json) =>
    MangaDatabaseItemReleaseStatus(
      $enumDecode(_$ReleaseStatusEnumMap, json['status']),
      json['source_name'] as String,
    );

Map<String, dynamic> _$MangaDatabaseItemReleaseStatusToJson(
        MangaDatabaseItemReleaseStatus instance) =>
    <String, dynamic>{
      'source_name': instance.sourceName,
      'status': _$ReleaseStatusEnumMap[instance.status]!,
    };

const _$ReleaseStatusEnumMap = {
  ReleaseStatus.onGoing: 'on_going',
  ReleaseStatus.dropped: 'dropped',
  ReleaseStatus.completed: 'completed',
  ReleaseStatus.cancelled: 'cancelled',
  ReleaseStatus.hiatus: 'hiatus',
  ReleaseStatus.unknown: 'unknown',
  ReleaseStatus.none: 'none',
};
