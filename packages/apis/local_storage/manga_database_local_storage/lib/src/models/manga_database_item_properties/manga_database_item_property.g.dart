// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_property.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemPropertyAdapter
    extends TypeAdapter<MangaDatabaseItemProperty> {
  @override
  final int typeId = 0;

  @override
  MangaDatabaseItemProperty read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemProperty(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemProperty obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.sourceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemPropertyAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
