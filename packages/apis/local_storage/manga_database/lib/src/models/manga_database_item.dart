import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

part 'manga_database_item.g.dart';

@HiveType(typeId: 11)
@JsonSerializable()
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
    );
  }

  factory MangaDatabaseItem.fromJson(Map<String, dynamic> json) =>
      _$MangaDatabaseItemFromJson(json);

  @HiveField(0)
  String? author;

  @HiveField(1)
  @JsonKey(name:'content_type')
  MangaDatabaseItemMangaType? contentType;

  @HiveField(2)
  @JsonKey(name:'cover_images')
  List<MangaDatabaseItemCoverImage> coverImages;

  @HiveField(3)
  List<MangaDatabaseItemDescription> descriptions;

  @HiveField(4)
  List<MangaDatabaseItemGenres> genres;

  // id should never change
  @HiveField(5)
  final String id;

  @HiveField(6)
  @JsonKey(name:'posted_on')
  List<MangaDatabaseItemPostedOn> postedOn;

  @HiveField(7)
  List<MangaDatabaseItemRating> rating;

  @HiveField(8)
  @JsonKey(name:'release_status')
  List<MangaDatabaseItemReleaseStatus> releaseStatus;

  @HiveField(9)
  // There should be no duplicates
  List<MangaDatabaseItemTitle> titles;

  @HiveField(10)
  List<MangaDatabaseItemUrl> urls;

  @override
  String toString() {
    // converts class to string interpretation
    return 'MangaDatabaseItem(\nid: $id,\ncoverImages: $coverImages,\ndescriptions: $descriptions,\ngenres: $genres,\nrating: $rating,\ntitles; $titles,\nuri: $urls,\n),\n';
  }

  /// get al list containing all titles without source name
  List<String> get allTitles {
    List<String> results = [];
    for (final title in titles) {
      results.add(title.title);
    }

    return results;
  }

  /// adds data to current database item and returns it
  void addData({
    required String mangaSourceName,
    required String mangaCoverImage,
    required String mangaDescription,
    required List<String> mangaGenres,
    required double mangaRating,
    required List<String> mangaTitles,
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
    for (int i = 0; i < mangaTitles.length; i++) {
      // if titles doesn't contain a mangaTitle, then add it
      if (!allTitles.contains(mangaTitles[i])) {
        titles.add(
          MangaDatabaseItemTitle(mangaTitles[i], mangaSourceName),
        );
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
