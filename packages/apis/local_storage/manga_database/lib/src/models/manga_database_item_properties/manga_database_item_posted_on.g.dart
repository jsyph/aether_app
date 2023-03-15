// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item_posted_on.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemPostedOnAdapter
    extends TypeAdapter<MangaDatabaseItemPostedOn> {
  @override
  final int typeId = 10;

  @override
  MangaDatabaseItemPostedOn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItemPostedOn(
      fields[1] as String,
      fields[0] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItemPostedOn obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.postedOn)
      ..writeByte(1)
      ..write(obj.sourceName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MangaDatabaseItemPostedOnAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaDatabaseItemPostedOn _$MangaDatabaseItemPostedOnFromJson(
        Map<String, dynamic> json) =>
    MangaDatabaseItemPostedOn(
      json['source_name'] as String,
      DateTime.parse(json['posted_on'] as String),
    );

Map<String, dynamic> _$MangaDatabaseItemPostedOnToJson(
        MangaDatabaseItemPostedOn instance) =>
    <String, dynamic>{
      'posted_on': instance.postedOn.toIso8601String(),
      'source_name': instance.sourceName,
    };
