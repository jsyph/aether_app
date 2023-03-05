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

  @HiveField(1)
  List<MangaDatabaseItemCoverImage> coverImages;

  @HiveField(2)
  List<MangaDatabaseItemDescription> descriptions;

  @HiveField(3)
  List<MangaDatabaseItemGenres> genres;

  @HiveField(4)
  // id should never change
  final String id;

  @HiveField(5)
  List<MangaDatabaseItemRating> rating;

  @HiveField(6)
  List<MangaDatabaseItemTitles> titles;

  @HiveField(7)
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

    titles.add(
      MangaDatabaseItemTitles(mangaTitles, mangaSourceName),
    );

    uri.add(
      MangaDatabaseItemUri(mangaUri, mangaSourceName),
    );
  }
}
