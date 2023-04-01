// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manga_database_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MangaDatabaseItemAdapter extends TypeAdapter<MangaDatabaseItem> {
  @override
  final int typeId = 0;

  @override
  MangaDatabaseItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MangaDatabaseItem(
      fields[6] as String,
      (fields[3] as List).cast<String>(),
      (fields[4] as List).cast<String>(),
      (fields[5] as List)
          .map((dynamic e) => (e as List).cast<String>())
          .toList(),
      (fields[11] as List).cast<String>(),
      (fields[12] as List).cast<String>(),
      (fields[8] as List).cast<double>(),
      fields[2] as MangaDatabaseItemMangaType?,
      fields[1] as String?,
      (fields[7] as List).cast<DateTime?>(),
      (fields[9] as List).cast<MangaDatabaseReleaseStatus>(),
      (fields[0] as List?)?.cast<String>(),
      (fields[10] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, MangaDatabaseItem obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.altTitles)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.contentType)
      ..writeByte(3)
      ..write(obj.coverImages)
      ..writeByte(4)
      ..write(obj.descriptions)
      ..writeByte(5)
      ..write(obj.genres)
      ..writeByte(6)
      ..write(obj.id)
      ..writeByte(7)
      ..write(obj.postedOn)
      ..writeByte(8)
      ..write(obj.rating)
      ..writeByte(9)
      ..write(obj.releaseStatus)
      ..writeByte(10)
      ..write(obj.sourceNames)
      ..writeByte(11)
      ..write(obj.titles)
      ..writeByte(12)
      ..write(obj.urls);
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

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MangaDatabaseItem _$MangaDatabaseItemFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'alt_titles',
      'author',
      'content_type',
      'cover_images',
      'descriptions',
      'genres',
      'id',
      'posted_on',
      'rating',
      'release_status',
      'source_names',
      'titles',
      'urls'
    ],
  );
  return MangaDatabaseItem(
    json['id'] as String,
    (json['cover_images'] as List<dynamic>).map((e) => e as String).toList(),
    (json['descriptions'] as List<dynamic>).map((e) => e as String).toList(),
    (json['genres'] as List<dynamic>)
        .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
        .toList(),
    (json['titles'] as List<dynamic>).map((e) => e as String).toList(),
    (json['urls'] as List<dynamic>).map((e) => e as String).toList(),
    (json['rating'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    $enumDecodeNullable(
        _$MangaDatabaseItemMangaTypeEnumMap, json['content_type']),
    json['author'] as String?,
    (json['posted_on'] as List<dynamic>)
        .map((e) => e == null ? null : DateTime.parse(e as String))
        .toList(),
    (json['release_status'] as List<dynamic>)
        .map((e) => $enumDecode(_$MangaDatabaseReleaseStatusEnumMap, e))
        .toList(),
    (json['alt_titles'] as List<dynamic>?)?.map((e) => e as String).toList(),
    (json['source_names'] as List<dynamic>).map((e) => e as String).toList(),
  );
}

Map<String, dynamic> _$MangaDatabaseItemToJson(MangaDatabaseItem instance) =>
    <String, dynamic>{
      'alt_titles': instance.altTitles,
      'author': instance.author,
      'content_type': _$MangaDatabaseItemMangaTypeEnumMap[instance.contentType],
      'cover_images': instance.coverImages,
      'descriptions': instance.descriptions,
      'genres': instance.genres,
      'id': instance.id,
      'posted_on': instance.postedOn.map((e) => e?.toIso8601String()).toList(),
      'rating': instance.rating,
      'release_status': instance.releaseStatus
          .map((e) => _$MangaDatabaseReleaseStatusEnumMap[e]!)
          .toList(),
      'source_names': instance.sourceNames,
      'titles': instance.titles,
      'urls': instance.urls,
    };

const _$MangaDatabaseItemMangaTypeEnumMap = {
  MangaDatabaseItemMangaType.manhua: 'manhua',
  MangaDatabaseItemMangaType.manhwa: 'manhwa',
  MangaDatabaseItemMangaType.manga: 'manga',
  MangaDatabaseItemMangaType.unknown: 'unknown',
};

const _$MangaDatabaseReleaseStatusEnumMap = {
  MangaDatabaseReleaseStatus.onGoing: 'on_going',
  MangaDatabaseReleaseStatus.dropped: 'dropped',
  MangaDatabaseReleaseStatus.completed: 'completed',
  MangaDatabaseReleaseStatus.cancelled: 'cancelled',
  MangaDatabaseReleaseStatus.hiatus: 'hiatus',
  MangaDatabaseReleaseStatus.unknown: 'unknown',
  MangaDatabaseReleaseStatus.none: 'none',
};
