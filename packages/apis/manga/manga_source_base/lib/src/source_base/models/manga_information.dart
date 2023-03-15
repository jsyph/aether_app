import 'models.dart';

/// Contains information on a manga series
class MangaInformation {
  MangaInformation({
    required this.title,
    required this.altTitles,
    required this.description,
    required this.genres,
    required this.rating,
    required this.coverImageUrl,
    required this.releaseStatus,
    required this.contentType,
    required this.author,
    required this.datePostedOn,
  });

  final List<String>? altTitles;
  final String? author;
  final MangaContentType? contentType;
  final String coverImageUrl;
  final DateTime? datePostedOn;
  final String description;
  final List<String> genres;
  final double rating;
  final MangaReleaseStatus releaseStatus;
  final String title;

  @override
  String toString() {
    return '''MangaInformation(\ntitle: $title,\naltTitles: $altTitles,\ndescription: $description,\ngenres: $genres,\nrating: 
    $rating,\ncoverImageUrl: $coverImageUrl,\nreleaseStatus: $releaseStatus,\ncontentType: $contentType,\nauthor: $author,\ndatePostedOn: $datePostedOn,\n),\n''';
  }
}
