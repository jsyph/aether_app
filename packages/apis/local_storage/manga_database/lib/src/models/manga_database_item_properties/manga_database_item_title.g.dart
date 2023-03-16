// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_title.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemTitleAdapter
    extends TypeAdapter<MangaDatabaseItemTitle> {
  @override
  final int typeId = 10;

  @override
  MangaDatabaseItemTitle read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemTitle(
      fields[1] as String,
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemTitle obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(0)
      ..write(obj.sourceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemTitleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaDatabaseItemTitle _$MangaDatabaseItemTitleFromJson(
        Map<String, dynamic> json) =>
    MangaDatabaseItemTitle(
      json['title'] as String,
      json['source_name'] as String,
    );

Map<String, dynamic> _$MangaDatabaseItemTitleToJson(
        MangaDatabaseItemTitle instance) =>
    <String, dynamic>{
      'source_name': instance.sourceName,
      'title': instance.title,
    };
