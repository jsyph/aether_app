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
      id: fields[4] as String,
      coverImages: (fields[1] as List).cast<MangaDatabaseItemCoverImage>(),
      descriptions: (fields[2] as List).cast<MangaDatabaseItemDescription>(),
      genres: (fields[3] as List).cast<MangaDatabaseItemGenres>(),
      titles: (fields[6] as List).cast<MangaDatabaseItemTitles>(),
      uri: (fields[7] as List).cast<MangaDatabaseItemUri>(),
      rating: (fields[5] as List).cast<MangaDatabaseItemRating>(),
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItem obj) {
    writer
      ..writeByte(7)
      ..writeByte(1)
      ..write(obj.coverImages)
      ..writeByte(2)
      ..write(obj.descriptions)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.rating)
      ..writeByte(6)
      ..write(obj.titles)
      ..writeByte(7)
      ..write(obj.uri);
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
