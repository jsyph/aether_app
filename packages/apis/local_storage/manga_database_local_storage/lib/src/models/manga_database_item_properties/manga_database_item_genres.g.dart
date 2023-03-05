// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_genres.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemGenresAdapter
    extends TypeAdapter<MangaDatabaseItemGenres> {
  @override
  final int typeId = 2;

  @override
  MangaDatabaseItemGenres read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemGenres(
      (fields[1] as List).cast<String>(),
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemGenres obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.genres)
      ..writeByte(0)
      ..write(obj.sourceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemGenresAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
