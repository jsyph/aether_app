// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_image.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemCoverImageAdapter
    extends TypeAdapter<MangaDatabaseItemCoverImage> {
  @override
  final int typeId = 3;

  @override
  MangaDatabaseItemCoverImage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemCoverImage(
      fields[1] as Uri,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemCoverImage obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.uri)
      ..writeByte(0)
      ..write(obj.sourceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemCoverImageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
