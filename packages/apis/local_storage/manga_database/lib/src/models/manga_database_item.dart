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
    this.sourceNames,
  );

  /// Create empty instance with a unique id
  factory MangaDatabaseItem.empty() {
    return MangaDatabaseItem(Uuid().v4().toString(), [], [], [], [], [], [],
        MangaDatabaseItemMangaType.unknown, '', [], [], [], []);
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
  List<String> coverImages;

  @HiveField(4)
  List<String> descriptions;

  @HiveField(5)
  List<List<String>> genres;

  // id should never change
  @HiveField(6)
  final String id;

  @HiveField(7)
  @JsonKey(name: 'posted_on')
  List<DateTime> postedOn;

  @HiveField(8)
  List<double> rating;

  @HiveField(9)
  @JsonKey(name: 'release_status')
  List<MangaDatabaseReleaseStatus> releaseStatus;

  @HiveField(10)
  @JsonKey(name: 'source_names')
  List<String> sourceNames;

  @HiveField(11)
  // There should be no duplicates
  List<String> titles;

  @HiveField(12)
  List<String> urls;

  @override
  String toString() {
    // converts class to string interpretation
    return 'MangaDatabaseItem(\nid: $id,\ncoverImages: $coverImages,\ndescriptions: $descriptions,\ngenres: $genres,\nrating: $rating,\ntitles; $titles,\naltTitles: $altTitles,\nuri: $urls,\n),\n';
  }

  /// get al list containing all titles without source name
  List<String> get allTitles {
    List<String> results = [];
    results.addAll(
      titles,
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

  /// Get data from record that belongs to a source
  MangaDatabaseItemFilterResult filter(String sourceName) {
    final sourceIndex = sourceNames.indexOf(sourceName);

    if (sourceIndex == -1) {
      throw MangaSourceNotFoundException('$sourceName is not found');
    }

    return MangaDatabaseItemFilterResult(
      altTitles: altTitles,
      author: author,
      contentType: contentType,
      coverImage: coverImages[sourceIndex],
      description: descriptions[sourceIndex],
      genres: genres[sourceIndex],
      id: id,
      postedOn: postedOn[sourceIndex],
      rating: rating[sourceIndex],
      releaseStatus: releaseStatus[sourceIndex],
      sourceName: sourceNames[sourceIndex],
      title: titles[sourceIndex],
      url: urls[sourceIndex],
    );
  }

  /// returns all record information as a list of MangaDatabaseItemFilterResult
  List<MangaDatabaseItemFilterResult> toList() {
    List<MangaDatabaseItemFilterResult> results = [];
    for (final sourceName in sourceNames) {
      results.add(filter(sourceName));
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
    required String mangaTitle,
    required List<String>? mangaAltTitles,
    required String mangaUrl,
    required MangaDatabaseItemMangaType? mangaContentType,
    required String? mangaAuthor,
    required DateTime mangaPostedOn,
    required MangaDatabaseReleaseStatus mangaReleaseStatus,
  }) {
    coverImages.add(mangaCoverImage);

    descriptions.add(
      mangaDescription,
    );

    genres.add(
      mangaGenres,
    );

    rating.add(
      mangaRating,
    );

    // avoid duplicate titles
    titles.add(mangaTitle);

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
      mangaUrl,
    );

    // if manga content type is not null , then assign it
    if (mangaContentType != null) {
      contentType = mangaContentType;
    }

    author ??= mangaAuthor;

    postedOn.add(
      mangaPostedOn,
    );

    releaseStatus.add(
      mangaReleaseStatus,
    );

    sourceNames.add(mangaSourceName);
  }

  Map<String, dynamic> toJson() => _$MangaDatabaseItemToJson(this);
}
