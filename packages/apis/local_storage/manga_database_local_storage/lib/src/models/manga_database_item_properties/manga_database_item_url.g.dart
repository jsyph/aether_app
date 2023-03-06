// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemUrlAdapter extends TypeAdapter<MangaDatabaseItemUrl> {
  @override
  final int typeId = 6;

  @override
  MangaDatabaseItemUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemUrl(
      fields[1] as String,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemUrl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sourceName)
      ..writeByte(1)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
