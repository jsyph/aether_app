// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ReleaseStatusAdapter extends TypeAdapter<ReleaseStatus> {
  @override
  final int typeId = 2;

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
