import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import 'models.dart';

part 'manga_database_item.g.dart';

@HiveType(typeId: 7)
class MangaDatabaseItem extends HiveObject {
  MangaDatabaseItem({
    required this.id,
    required this.coverImages,
    required this.descriptions,
    required this.genres,
    required this.titles,
    required this.uri,
    required this.rating,
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
      uri: [],
    );
  }

  @HiveField(0)
  List<MangaDatabaseItemCoverImage> coverImages;

  @HiveField(1)
  List<MangaDatabaseItemDescription> descriptions;

  @HiveField(2)
  List<MangaDatabaseItemGenres> genres;

  @HiveField(3)
  // id should never change
  final String id;

  @HiveField(4)
  List<MangaDatabaseItemRating> rating;

  @HiveField(5)
  // There should be no duplicates
  List<MangaDatabaseItemTitles> titles;

  @HiveField(6)
  List<MangaDatabaseItemUri> uri;

  @override
  String toString() {
    // converts class to string interpretation
    return 'MangaDatabaseItem(\nid: $id,\ncoverImages: $coverImages,\ndescriptions: $descriptions,\ngenres: $genres,\nrating: $rating,\ntitles; $titles,\nuri: $uri,\n),\n';
  }

  /// get al list containing all titles without source name
  List<String> get allTitles {
    List<String> result = [];
    for (int i = 0; i < titles.length; i++) {
      result.addAll(titles[i].titles);
    }

    return result;
  }

  /// adds data to current database item and returns it
  void addData(
    String mangaSourceName,
    Uri mangaCoverImage,
    String mangaDescription,
    List<String> mangaGenres,
    double mangaRating,
    List<String> mangaTitles,
    Uri mangaUri,
  ) {
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

    List<String> titlesToBeAdded = [];
    // avoid duplicate titles
    for (int i = 0; i < mangaTitles.length; i++) {
      // if titles doesn't contain a mangaTitle, then add it
      if (!allTitles.contains(mangaTitles[i])) {
        titlesToBeAdded.add(mangaTitles[i]);
      }
    }

    titles.add(
      MangaDatabaseItemTitles(titlesToBeAdded, mangaSourceName),
    );

    uri.add(
      MangaDatabaseItemUri(mangaUri, mangaSourceName),
    );
  }
}
