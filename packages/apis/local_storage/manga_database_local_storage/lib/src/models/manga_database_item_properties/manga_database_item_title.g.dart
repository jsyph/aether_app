// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_title.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemTitlesAdapter
    extends TypeAdapter<MangaDatabaseItemTitles> {
  @override
  final int typeId = 5;

  @override
  MangaDatabaseItemTitles read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemTitles(
      (fields[1] as List).cast<String>(),
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemTitles obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sourceName)
      ..writeByte(1)
      ..write(obj.titles);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemTitlesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
