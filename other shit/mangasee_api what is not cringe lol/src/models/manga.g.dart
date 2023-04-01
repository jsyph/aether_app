// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaSeeMangaAdapter extends TypeAdapter<MangaSeeManga> {
  @override
  final int typeId = 1;

  @override
  MangaSeeManga read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaSeeManga(
      alternativeDisplayNames: (fields[0] as List).cast<String>(),
      authors: (fields[1] as List).cast<String>(),
      displayName: fields[2] as String,
      genres: (fields[3] as List).cast<String>(),
      isOfficalTranslation: fields[5] as bool,
      isHot: fields[4] as bool,
      latestChapterId: fields[6] as String,
      mangaType: fields[7] as MangaSeeMangaType,
      scanStatus: fields[8] as MangaSeeMangaScanStatus,
      urlSafeName: fields[9] as String,
      yearUploaded: fields[10] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaSeeManga obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.alternativeDisplayNames)
      ..writeByte(1)
      ..write(obj.authors)
      ..writeByte(2)
      ..write(obj.displayName)
      ..writeByte(3)
      ..write(obj.genres)
      ..writeByte(4)
      ..write(obj.isHot)
      ..writeByte(5)
      ..write(obj.isOfficalTranslation)
      ..writeByte(6)
      ..write(obj.latestChapterId)
      ..writeByte(7)
      ..write(obj.mangaType)
      ..writeByte(8)
      ..write(obj.scanStatus)
      ..writeByte(9)
      ..write(obj.urlSafeName)
      ..writeByte(10)
      ..write(obj.yearUploaded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaSeeMangaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
