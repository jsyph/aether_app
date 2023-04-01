import 'package:hive/hive.dart';

part 'manga_type.g.dart';

/// Conatins the types of manga that are available on MangaSee
@HiveType(typeId: 2)
enum MangaSeeMangaType {
  @HiveField(0)
  doujinshi,

  @HiveField(1)
  manga,

  @HiveField(2)
  manhua,

  @HiveField(3)
  manhwa,

  @HiveField(4)
  oel,

  @HiveField(5)
  oneShot;

  factory MangaSeeMangaType.fromString(String string) {
    final fomattedString = string.toLowerCase();
    switch (fomattedString) {
      case 'doujinshi':
        return MangaSeeMangaType.doujinshi;
      case 'manga':
        return MangaSeeMangaType.manga;
      case 'manhua':
        return MangaSeeMangaType.manhua;
      case 'manhwa':
        return MangaSeeMangaType.manhwa;
      case 'oel':
        return MangaSeeMangaType.oel;
      case 'one-shot':
        return MangaSeeMangaType.oneShot;
      default:
        throw InvalidMangaType(string);
    }
  }
}

class InvalidMangaType implements Exception {
  final String cause;

  InvalidMangaType(this.cause);
}
