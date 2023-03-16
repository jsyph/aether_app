import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

part 'manga_database_item.g.dart';

@HiveType(typeId: 0)
@JsonSerializable(disallowUnrecognizedKeys: true)
class MangaDatabaseItem extends HiveObject {
  MangaDatabaseItem(
    this.id,
    this.coverImages,
    this.descriptions,
    this.genres,
    this.titles,
    this.urls,
    this.rating,
    this.contentType,
    this.author,
    this.postedOn,
    this.releaseStatus,
    this.altTitles,
  );

  /// Create empty instance with a unique id
  factory MangaDatabaseItem.empty() {
    return MangaDatabaseItem(
      Uuid().v4().toString(),
      [],
      [],
      [],
      [],
      [],
      [],
      MangaDatabaseItemMangaType.unknown,
      '',
      [],
      [],
      [],
    );
  }

  factory MangaDatabaseItem.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemFromJson(json);

  @HiveField(0)
  @JsonKey(name: 'alt_titles')
  List<String>? altTitles;

  @HiveField(1)
  String? author;

  @HiveField(2)
  @JsonKey(name: 'content_type')
  MangaDatabaseItemMangaType? contentType;

  @HiveField(3)
  @JsonKey(name: 'cover_images')
  List<MangaDatabaseItemCoverImage> coverImages;

  @HiveField(4)
  List<MangaDatabaseItemDescription> descriptions;

  @HiveField(5)
  List<MangaDatabaseItemGenres> genres;

  // id should never change
  @HiveField(6)
  final String id;

  @HiveField(7)
  @JsonKey(name: 'posted_on')
  List<MangaDatabaseItemPostedOn> postedOn;

  @HiveField(8)
  List<MangaDatabaseItemRating> rating;

  @HiveField(9)
  @JsonKey(name: 'release_status')
  List<MangaDatabaseItemReleaseStatus> releaseStatus;

  @HiveField(10)
  // There should be no duplicates
  List<MangaDatabaseItemTitle> titles;

  @HiveField(11)
  List<MangaDatabaseItemUrl> urls;

  @override
  String toString() {
    // converts class to string interpretation
    return 'MangaDatabaseItem(\nid: $id,\ncoverImages: $coverImages,\ndescriptions: $descriptions,\ngenres: $genres,\nrating: $rating,\ntitles; $titles,\naltTitles: $altTitles,\nuri: $urls,\n),\n';
  }

  /// get al list containing all titles without source name
  List<String> get allTitles {
    List<String> results = [];
    results.addAll(
      titles.map((e) => e.title),
    );

    if (altTitles != null) {
      results.addAll(
        altTitles!,
      );
    }

    // remove duplicates
    results = results.toSet().toList();

    return results;
  }

  /// adds data to current database item and returns it
  void addData({
    required String mangaSourceName,
    required String mangaCoverImage,
    required String mangaDescription,
    required List<String> mangaGenres,
    required double mangaRating,
    required String mangaTitle,
    required List<String>? mangaAltTitles,
    required String mangaUrl,
    required MangaDatabaseItemMangaType? mangaContentType,
    required String? mangaAuthor,
    required DateTime mangaPostedOn,
    required ReleaseStatus mangaReleaseStatus,
  }) {
    coverImages.add(
      MangaDatabaseItemCoverImage(mangaCoverImage, mangaSourceName),
    );

    descriptions.add(
      MangaDatabaseItemDescription(mangaDescription, mangaSourceName),
    );

    genres.add(
      MangaDatabaseItemGenres(mangaGenres, mangaSourceName),
    );

    rating.add(
      MangaDatabaseItemRating(mangaRating, mangaSourceName),
    );

    // avoid duplicate titles
    titles.add(
      MangaDatabaseItemTitle(
        mangaTitle,
        mangaSourceName,
      ),
    );

    // if altTitles and mangaAltTitles are not null,
    // then check if altTitles contains any title from mangaAltTitles,
    //if not then add it
    if (altTitles != null && mangaAltTitles != null) {
      for (final mangaAltTitle in mangaAltTitles) {
        if (!altTitles!.contains(mangaAltTitle)) {
          altTitles!.add(mangaAltTitle);
        }
      }
    }

    urls.add(
      MangaDatabaseItemUrl(mangaUrl, mangaSourceName),
    );

    // if manga content type is not null , then assign it
    if (mangaContentType != null) {
      contentType = mangaContentType;
    }

    author ??= mangaAuthor;

    postedOn.add(
      MangaDatabaseItemPostedOn(
        mangaSourceName,
        mangaPostedOn,
      ),
    );

    releaseStatus.add(
      MangaDatabaseItemReleaseStatus(
        mangaReleaseStatus,
        mangaSourceName,
      ),
    );
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemToJson(this);
}
