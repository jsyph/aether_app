import 'models.dart';
import 'package:hive/hive.dart';

part 'manga.g.dart';

/// ### Represents each the data from the MangaSee directory json
///
/// Example: json
/// ```json
/// {
///  i: "Killstagram",
///  s: "#Killstagram",
///  o: "yes",
///  ss: "Ongoing",
///  ps: "Ongoing",
///  t: "Manhwa",
///  v: "000053523",
///  vm: "000002298",
///  y: "2019",
///  a: ["Ryoung"],
///  al: [],
///  l: "100430",
///  lt: 1610161702,
///  ls: "2021-01-09T03:08:22+00:00",
///  g: ["Horror", "Josei", "Psychological"],
///  h: false,
/// },
/// ```
///
@HiveType(typeId: 1)
class MangaSeeManga {
    MangaSeeManga({
    required this.alternativeDisplayNames,
    required this.authors,
    required this.displayName,
    required this.genres,
    required this.isOfficalTranslation,
    required this.isHot,
    required this.latestChapterId,
    required this.mangaType,
    required this.scanStatus,
    required this.urlSafeName,
    required this.yearUploaded,
  });

  factory MangaSeeManga.fromJson(Map<String, dynamic> json) {
    final alternativeDisplayNames = List<String>.from(json['al']);
    final authors = List<String>.from(['a']);
    final genres = List<String>.from(json['g']);

    return MangaSeeManga(
      alternativeDisplayNames: alternativeDisplayNames,
      authors: authors,
      displayName: json['s'],
      genres: genres,
      isOfficalTranslation: json['o'] == 'yes' ? true : false,
      isHot: json['h'],
      latestChapterId: json['l'],
      mangaType: MangaSeeMangaType.fromString(json['t']),
      scanStatus: MangaSeeMangaScanStatus.fromString(json['ss']),
      urlSafeName: json['i'],
      yearUploaded: json['y'],
    );
  }

  @HiveField(0)
  final List<String> alternativeDisplayNames;

  @HiveField(1)
  final List<String> authors;

  @HiveField(2)
  final String displayName;

  @HiveField(3)
  final List<String> genres;

  @HiveField(4)
  final bool isHot;

  @HiveField(5)
  final bool isOfficalTranslation;

  @HiveField(6)
  final String latestChapterId;

  @HiveField(7)
  final MangaSeeMangaType mangaType;

  @HiveField(8)
  final MangaSeeMangaScanStatus scanStatus;

  @HiveField(9)
  final String urlSafeName;

  @HiveField(10)
  final String yearUploaded;

  @override
  String toString() {
    return '''\nMangaSeeManga(
      alternativeDisplayNames: ${alternativeDisplayNames.toString()},
      authors: ${authors.toString()},
      displayName: $displayName,
      genres: ${genres.toString()},
      isHot: ${isHot.toString()},
      isOfficalTranslation: ${isOfficalTranslation.toString()},
      latestChapterId: $latestChapterId,
      mangaType: ${mangaType.toString()},
      scanStatus: ${scanStatus.toString()},
      urlSafeName: $urlSafeName,
      yearUploaded: $yearUploaded,
    ''';
  }

  /// Returns the rss feed url for a manga series using its url safe name
  String get rssFeedUrl => 'https://mangasee123.com/rss/$urlSafeName.xml';

  /// Returns the cover image of a manga using its url safe name
  String get covrImage => 'https://temp.compsci88.com/cover/$urlSafeName.jpg';
}
