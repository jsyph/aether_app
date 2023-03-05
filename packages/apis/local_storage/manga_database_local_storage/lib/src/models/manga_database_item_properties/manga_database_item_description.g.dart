// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_description.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemDescriptionAdapter
    extends TypeAdapter<MangaDatabaseItemDescription> {
  @override
  final int typeId = 1;

  @override
  MangaDatabaseItemDescription read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemDescription(
      fields[1] as String,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemDescription obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sourceName)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemDescriptionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
