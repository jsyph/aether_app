// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_uri.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemUriAdapter extends TypeAdapter<MangaDatabaseItemUri> {
  @override
  final int typeId = 6;

  @override
  MangaDatabaseItemUri read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemUri(
      fields[1] as Uri,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemUri obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sourceName)
      ..writeByte(1)
      ..write(obj.uri);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemUriAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
