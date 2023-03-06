import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

part 'manga_database_item.g.dart';

@HiveType(typeId: 8)
class MangaDatabaseItem extends HiveObject {
  MangaDatabaseItem({
    required this.id,
    required this.coverImages,
    required this.descriptions,
    required this.genres,
    required this.titles,
    required this.urls,
    required this.rating,
    required this.contentType,
  });

  /// Create empty instance with a unique id
  factory MangaDatabaseItem.empty() {
    return MangaDatabaseItem(
      coverImages: [],
      descriptions: [],
      genres: [],
      id: Uuid().v4(),
      rating: [],
      titles: [],
      urls: [],
      contentType: MangaDatabaseItemMangaType.unknown,
    );
  }

  @HiveField(7)
  MangaDatabaseItemMangaType? contentType;

  @HiveField(0)
  List<MangaDatabaseItemCoverImage> coverImages;

  @HiveField(1)
  List<MangaDatabaseItemDescription> descriptions;

  @HiveField(2)
  List<MangaDatabaseItemGenres> genres;

  // id should never change
  @HiveField(3)
  final String id;

  @HiveField(4)
  List<MangaDatabaseItemRating> rating;

  @HiveField(5)
  // There should be no duplicates
  List<MangaDatabaseItemTitle> titles;

  @HiveField(6)
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
    MangaDatabaseItemMangaType? mangaContentType,
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
  }
}
