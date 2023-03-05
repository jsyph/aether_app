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
    return MangaDatabaseItemProperty();
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemProperty obj) {
    writer.writeByte(0);
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
