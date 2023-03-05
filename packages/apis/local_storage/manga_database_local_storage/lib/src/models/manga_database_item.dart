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
    required this.uris,
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
      uris: [],
    );
  }

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
  List<MangaDatabaseItemTitles> titles;

  @HiveField(6)
  List<MangaDatabaseItemUri> uris;

  @override
  String toString() {
    // converts class to string interpretation
    return 'MangaDatabaseItem(\nid: $id,\ncoverImages: $coverImages,\ndescriptions: $descriptions,\ngenres: $genres,\nrating: $rating,\ntitles; $titles,\nuri: $uris,\n),\n';
  }

  /// get al list containing all titles without source name
  List<String> get allTitles {
    List<String> results = [];
    for (int i = 0; i < titles.length; i++) {
      results.addAll(titles[i].titles);
    }

    return results;
  }

  /// adds data to current database item and returns it
  void addData(
    String mangaSourceName,
    String mangaCoverImage,
    String mangaDescription,
    List<String> mangaGenres,
    double mangaRating,
    List<String> mangaTitles,
    String mangaUri,
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

    uris.add(
      MangaDatabaseItemUri(mangaUri, mangaSourceName),
    );
    
  }
}
