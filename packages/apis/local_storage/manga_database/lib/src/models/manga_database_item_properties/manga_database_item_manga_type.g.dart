// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_manga_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemMangaTypeAdapter
    extends TypeAdapter<MangaDatabaseItemMangaType> {
  @override
  final int typeId = 5;

  @override
  MangaDatabaseItemMangaType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MangaDatabaseItemMangaType.manhua;
      case 1:
        return MangaDatabaseItemMangaType.manhwa;
      case 2:
        return MangaDatabaseItemMangaType.manga;
      case 3:
        return MangaDatabaseItemMangaType.unknown;
      case 4:
        return MangaDatabaseItemMangaType.none;
      default:
        return MangaDatabaseItemMangaType.manhua;
    }
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemMangaType obj) {
    switch (obj) {
      case MangaDatabaseItemMangaType.manhua:
        writer.writeByte(0);
        break;
      case MangaDatabaseItemMangaType.manhwa:
        writer.writeByte(1);
        break;
      case MangaDatabaseItemMangaType.manga:
        writer.writeByte(2);
        break;
      case MangaDatabaseItemMangaType.unknown:
        writer.writeByte(3);
        break;
      case MangaDatabaseItemMangaType.none:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemMangaTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
