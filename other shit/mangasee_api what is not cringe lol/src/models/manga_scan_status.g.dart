// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_scan_status.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaSeeMangaScanStatusAdapter
    extends TypeAdapter<MangaSeeMangaScanStatus> {
  @override
  final int typeId = 3;

  @override
  MangaSeeMangaScanStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MangaSeeMangaScanStatus.cancelled;
      case 1:
        return MangaSeeMangaScanStatus.complete;
      case 2:
        return MangaSeeMangaScanStatus.discontinued;
      case 3:
        return MangaSeeMangaScanStatus.hiatus;
      case 4:
        return MangaSeeMangaScanStatus.ongoing;
      default:
        return MangaSeeMangaScanStatus.cancelled;
    }
  }

  @override
  void write(BinaryWriter writer, MangaSeeMangaScanStatus obj) {
    switch (obj) {
      case MangaSeeMangaScanStatus.cancelled:
        writer.writeByte(0);
        break;
      case MangaSeeMangaScanStatus.complete:
        writer.writeByte(1);
        break;
      case MangaSeeMangaScanStatus.discontinued:
        writer.writeByte(2);
        break;
      case MangaSeeMangaScanStatus.hiatus:
        writer.writeByte(3);
        break;
      case MangaSeeMangaScanStatus.ongoing:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaSeeMangaScanStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
