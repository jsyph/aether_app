// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemAdapter extends TypeAdapter<MangaDatabaseItem> {
  @override
  final int typeId = 7;

  @override
  MangaDatabaseItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItem(
      id: fields[3] as String,
      coverImages: (fields[0] as List).cast<MangaDatabaseItemCoverImage>(),
      descriptions: (fields[1] as List).cast<MangaDatabaseItemDescription>(),
      genres: (fields[2] as List).cast<MangaDatabaseItemGenres>(),
      titles: (fields[5] as List).cast<MangaDatabaseItemTitle>(),
      uris: (fields[6] as List).cast<MangaDatabaseItemUri>(),
      rating: (fields[4] as List).cast<MangaDatabaseItemRating>(),
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.coverImages)
      ..writeByte(1)
      ..write(obj.descriptions)
      ..writeByte(2)
      ..write(obj.genres)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.titles)
      ..writeByte(6)
      ..write(obj.uris);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
