import 'package:hive/hive.dart';

part 'manga_scan_status.g.dart';

/// Contains the Scan Statuses for manga from MangaSee
@HiveType(typeId: 3)
enum MangaSeeMangaScanStatus {
  @HiveField(0)
  cancelled,
  
  @HiveField(1)
  complete,

  @HiveField(2)
  discontinued,

  @HiveField(3)
  hiatus,

  @HiveField(4)
  ongoing;

  factory MangaSeeMangaScanStatus.fromString(String string) {
    final fomattedString = string.toLowerCase();

    switch (fomattedString) {
      case 'cancelled':
        return MangaSeeMangaScanStatus.cancelled;
      case 'complete':
        return MangaSeeMangaScanStatus.complete;
      case 'discontinued':
        return MangaSeeMangaScanStatus.discontinued;
      case 'hiatus':
        return MangaSeeMangaScanStatus.hiatus;
      case 'ongoing':
        return MangaSeeMangaScanStatus.ongoing;
      default:
        throw InvalidScanStatus(string);
    }
  }
}

class InvalidScanStatus implements Exception {
  final String cause;

  InvalidScanStatus(this.cause);
}
