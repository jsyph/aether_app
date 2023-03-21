// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseReleaseStatusAdapter
    extends TypeAdapter<MangaDatabaseReleaseStatus> {
  @override
  final int typeId = 2;

  @override
  MangaDatabaseReleaseStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MangaDatabaseReleaseStatus.onGoing;
      case 1:
        return MangaDatabaseReleaseStatus.dropped;
      case 2:
        return MangaDatabaseReleaseStatus.completed;
      case 3:
        return MangaDatabaseReleaseStatus.cancelled;
      case 4:
        return MangaDatabaseReleaseStatus.hiatus;
      case 5:
        return MangaDatabaseReleaseStatus.unknown;
      case 6:
        return MangaDatabaseReleaseStatus.none;
      default:
        return MangaDatabaseReleaseStatus.onGoing;
    }
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseReleaseStatus obj) {
    switch (obj) {
      case MangaDatabaseReleaseStatus.onGoing:
        writer.writeByte(0);
        break;
      case MangaDatabaseReleaseStatus.dropped:
        writer.writeByte(1);
        break;
      case MangaDatabaseReleaseStatus.completed:
        writer.writeByte(2);
        break;
      case MangaDatabaseReleaseStatus.cancelled:
        writer.writeByte(3);
        break;
      case MangaDatabaseReleaseStatus.hiatus:
        writer.writeByte(4);
        break;
      case MangaDatabaseReleaseStatus.unknown:
        writer.writeByte(5);
        break;
      case MangaDatabaseReleaseStatus.none:
        writer.writeByte(6);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseReleaseStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
