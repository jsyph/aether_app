// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_rating.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemRatingAdapter
    extends TypeAdapter<MangaDatabaseItemRating> {
  @override
  final int typeId = 4;

  @override
  MangaDatabaseItemRating read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemRating(
      fields[1] as double,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemRating obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.sourceName)
      ..writeByte(1)
      ..write(obj.rating);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemRatingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
