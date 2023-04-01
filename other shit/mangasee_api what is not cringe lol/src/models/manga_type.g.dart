// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaSeeMangaTypeAdapter extends TypeAdapter<MangaSeeMangaType> {
  @override
  final int typeId = 2;

  @override
  MangaSeeMangaType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MangaSeeMangaType.doujinshi;
      case 1:
        return MangaSeeMangaType.manga;
      case 2:
        return MangaSeeMangaType.manhua;
      case 3:
        return MangaSeeMangaType.manhwa;
      case 4:
        return MangaSeeMangaType.oel;
      case 5:
        return MangaSeeMangaType.oneShot;
      default:
        return MangaSeeMangaType.doujinshi;
    }
  }

  @override
  void write(BinaryWriter writer, MangaSeeMangaType obj) {
    switch (obj) {
      case MangaSeeMangaType.doujinshi:
        writer.writeByte(0);
        break;
      case MangaSeeMangaType.manga:
        writer.writeByte(1);
        break;
      case MangaSeeMangaType.manhua:
        writer.writeByte(2);
        break;
      case MangaSeeMangaType.manhwa:
        writer.writeByte(3);
        break;
      case MangaSeeMangaType.oel:
        writer.writeByte(4);
        break;
      case MangaSeeMangaType.oneShot:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaSeeMangaTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
